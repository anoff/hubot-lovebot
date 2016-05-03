# hubot-lovebot

post thecodinglove.com images randomly

See [`src/lovebot.coffee`](src/lovebot.coffee) for full documentation.

## Installation
*This is currently no npm repo*
In hubot project repo, run:

`npm install hubot-lovebot --save`

Then add **hubot-lovebot** to your `external-scripts.json`:

```json
[
  "hubot-lovebot"
]
```

## Get a single codinglove image

```
user1>> hubot love me
hubot>> Last lines of code on friday
hubot>> http://tclhost.com/OwZkUVO.gif

```

## Get codinglove for the rest of your (hubots) life

```
user1>> hubot keep up the love 10
# hubot will bring you codinglove every 10-20 minutes
```
