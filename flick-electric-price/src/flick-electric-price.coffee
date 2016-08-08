FlickAPI = require 'flick-electric-api'

module.exports = (RED) ->
	FlickElectricPrice = (config) ->
		# set up node
		RED.nodes.createNode this, config
		
		# check credentials
		unless @credentials.username and @credentials.password
			@error "Missing username/password"
			return
		
		# set up API
		flick = new FlickAPI(@credentials.username, @credentials.password)
		
		# when an input arrives, get the current price
		@on 'input', (msg) =>
			flick.get_price()
			flick.once 'price', (price) =>
				msg.payload = price
				@send msg
		
		# update status
		flick.on 'error', (err, details) =>
			@error "#{err}: #{details}"
			@status fill:"red", shape:"dot", text:"error"
		
		flick.on 'authenticated', =>
			@status fill:"green", shape:"dot", text:"authenticated"
		
		# return null or you'll get odd "TypeError: node.receive is not a function" errors!
		null
	
	RED.nodes.registerType "flick-electric-price", FlickElectricPrice, {
		credentials: {
			username: {type:"text"},
			password: {type:"password"}
		}
	}
