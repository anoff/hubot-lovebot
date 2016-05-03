# Description
#   post thecodinglove.com images randomly
#
# Configuration:
#   -
#
# Commands:
#   hubot love me - return random cdl image
#   hubot keep up the love <minTime> [maxTime] - provide love in random intervals (maxTime: default 2*minTime) [min]
#   hubot feed me love [interval] - post only new images (check every interval: default 10 min)
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   anoff <offispam@gmail.com>
#   inspired by https://github.com/hubot-scripts/hubot-codinglove (especially the web scraping part)

cheerio = require('cheerio')
he = require('he')

# variables for random and latest image
LATEST = "http://thecodinglove.com"
RANDOM = "http://thecodinglove.com/random"

module.exports = (robot) ->
  robot.respond /love me/, (res) ->
    get_love(robot, RANDOM, handler(res))

  robot.hear /orly/, ->
    res.send "yarly"

handler = (res) ->
  return (text) ->
    res.send text

get_love = (robot, url, handler) ->
  robot.http(url).get() (err, res, body) ->
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