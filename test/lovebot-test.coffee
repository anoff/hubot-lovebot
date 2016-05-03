chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'lovebot', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/lovebot')(@robot)

  it 'registers all respond listeners', ->
    expect(@robot.respond).to.have.been.calledWith(/love me/)
    expect(@robot.respond).to.have.been.calledWith(/keep up the love ([0-9]+) ?([0-9]*)/)
    expect(@robot.respond).to.have.been.calledWith(/stop the love/)
