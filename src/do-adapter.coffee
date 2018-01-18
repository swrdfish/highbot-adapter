{Adapter, TextMessage, Robot, User} = require.main.require 'hubot'

DoClient = require './client'


class DoAdapter extends Adapter

  constructor: ->
    super
    @robot.name = 'highbot'
    @robot.logger.info "Constructor"
    @client = new DoClient @robot

  send: (envelope, strings...) ->
    @client.send(strings)
    @robot.logger.info "Send"

  reply: (envelope, strings...) ->
    @robot.logger.info "Reply"

  run: ->
    @robot.logger.info "Starting Do adapter..."
    @client.socket.on 'connect', @open
    @client.socket.on 'message received', @reaction  
    @client.connect()

  open: =>
    @robot.logger.info 'Do chat now connected!'
    @emit "connected"

  reaction: (message) =>
    if (message.username == 'highbot') 
      return
    else
      user = new User 1001, name: message.username
    textMessage = new TextMessage(user, message.message, '123')
    textMessage.token = message.token
    @receive textMessage

exports.use = (robot) ->
  new DoAdapter robot
