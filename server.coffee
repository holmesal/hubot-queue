require 'newrelic'
Firebase = require 'firebase'
winston = require 'winston'
http = require 'http'

# Class to interact with the hubot adapter
HubotMessage = require './hubotMessage'

console.log "Shortwave hubot server booting..."
console.log "Environment variable is: #{process.env.NODE_ENV}"

if process.env.NODE_ENV is 'production'
	type = 'production'
	# Use the production firebase and creds
	# hubotQueue will be added to your URL
	firebaseURL = 'http://earshot.firebaseio.com' # hubotQueue will be added

else
	type = 'development'
	# Use the development firebase
	# hubotQueue will be added to your URL
	firebaseURL = 'http://earshot-dev.firebaseio.com' 

console.log "using #{type} environment"

# Connect to their firebase
# IMPORTANT - MAKE SURE TO REFERENCE PUSH QUEUE
@rootRef = new Firebase "#{firebaseURL}/hubotQueue"

# Listen for childAdded events on the firebse hubot queue
@rootRef.on 'child_added', (snapshot) =>
	try
		# Make a new hubot message to kick things off
		hubotMessage = new HubotMessage snapshot.val(), snapshot.ref()
	catch err
		console.error "Error parsing item... deleting..."
		console.error snapshot.val()
		console.error err


# Create a little http server to respond to uptime requests
server = http.createServer (req, res) ->
	res.writeHead 200, 
		'Content-Type': 'text/plain'
	res.end "The shortwave hubot server is up and is of the #{type} flavor!"
server.listen process.env.PORT