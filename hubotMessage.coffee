{EventEmitter} = require 'events'
winston = require 'winston'
Firebase = require 'firebase'


class HubotMessage extends EventEmitter

	log: (thing) ->
		console.log thing

	constructor: (@hubotQueueItem, @ref) ->

		# Do all of the adapter-specific hubot stuff here
		# When you're done, call @deleteQueueItem to remove it from the firebase queue


	deleteQueueItem: ->
		@ref.remove()

module.exports = HubotMessage

