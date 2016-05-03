# Description
#   randomly post thecodinglove.com images
#
# Commands:
#   hubot love me - return random cdl image
#   hubot keep up the love <minTime> [maxTime] - provide love in random intervals (maxTime: default 2*minTime) [min]
#   hubot stop the love - stop an existing love feed
#
# Todos:
#   hubot feed me love [interval] - post only new images (check every interval: default 10 min)
#   allow subscriptions per room
# Dependencies:
#   cheerio
#
# Author:
#   anoff <offispam@gmail.com>
#   inspired by https://github.com/hubot-scripts/hubot-codinglove (especially the web scraping part)

cheerio = require('cheerio')

# variables for random and latest image
LATEST = "http://thecodinglove.com"
RANDOM = "http://thecodinglove.com/random"

# global timer variable for deletion
timer = null

module.exports = (robot) ->
  robot.respond /love me/, (res) ->
    get_love(robot, RANDOM, handler(res))

  robot.respond /keep up the love ([0-9]+) ?([0-9]*)/, (res) ->
    minTime = parseInt res.match[1]
    maxTime = parseInt (res.match[2] ? minTime*2)
    maxTime = 2*minTime if isNaN(maxTime)
    clearTimeout timer if timer
    timer = execute_in minTime, maxTime, get_love.bind(this, robot, RANDOM, handler(res))

  robot.respond /stop the love/, (res) ->
    clearTimeout timer
    timer = null
    res.send "fine whatever.."

execute_in = (minTime, maxTime, fn) ->
  delay = minTime + Math.random() * Math.max(0, maxTime - minTime)
  return setTimeout () ->
    fn()
    timer = execute_in minTime, maxTime, fn
  , delay*1000

handler = (res) ->
  return (text) ->
    res.send text

get_love = (robot, url, handler) ->
  console.log "getting some love"
  robot.http(url).get() (err, res, body) ->
    return handler("i feel sick") if err
    return get_love(robot, res.headers.location, handler) if res.headers.location

    image = get_image(body, ".post img")
    text = get_text(body, ".post h3")
    
    handler(text)
    handler(image)

get_image = (body, selector)->
  $ = cheerio.load(body)
  $(selector).first().attr('src').replace(/\.jpe?g/i, '.gif')

get_text = (body, selector)->
  $ = cheerio.load(body)
  $(selector).first().text().replace(/<(?:.|\n)*?>/gm, '')
