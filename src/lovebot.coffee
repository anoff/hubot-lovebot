# Description
#   post thecodinglove.com images randomly
#
# Configuration:
#   -
#
# Commands:
#   hubot love me - return random cdl image
#   hubot keep up the love <minTime> [maxTime] - provide love in random intervals (minTime, maxTime: default 2*minTime) [min]
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   anoff <offispam@gmail.com>
#   inspired by https://github.com/hubot-scripts/hubot-codinglove (especially the web scraping part)

cheerio = require('cheerio')

# variables for random and latest image
LATEST = "http://thecodinglove.com"
RANDOM = "http://thecodinglove.com/random"

module.exports = (robot) ->
  robot.respond /love me/, (res) ->
    get_love(robot, RANDOM, handler)

  robot.hear /orly/, ->
    res.send "yarly"

handler = (res, text) ->
  res.send text

get_love = (robot, url, handler) ->
  robot.http(url).get() (err, res, body) ->
    image = get_image(body, ".post img")
    text = get_text(body, ".post h3")
    
    handler(text)
    handler(image)

get_image = (body, selector)->
  $ = cheerio.load(body)
  $(selector).first().attr('src').replace(/\.jpe?g/i, '.gif')

get_txt = (body, selector)->
  $ = cheerio.load(body)
  he.decode $(selector).first().text()