_ = require 'lodash'
io = require 'socket.io-client'


class DoClient
  constructor: (robot) ->
    @robot = robot
    @socket = io('http://172.26.90.108:8080', { autoConnect: false })

  connect: ->
    @socket.open()

  send: (strings...)->
    @socket.emit('message sent', {username: 'highbot', message: strings})

module.exports = DoClient