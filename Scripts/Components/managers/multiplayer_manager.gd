extends Node

var IS_MULTIPLAYER := false
var IS_HOST := false
var IS_CLIENT := false
var HOST := "localhost"
var PORT := -1
var CLIENT_ID := -1

var SERVER: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

func _reset_multiplayer_state():
	IS_MULTIPLAYER = false
	IS_HOST = false
	IS_CLIENT = false
	PORT = -1
	CLIENT_ID = -1

func _on_peer_connect(id: int):
	print_debug("Peer connected: %s" % id)
	CLIENT_ID = id

func _on_peer_disconnect(id: int):
	print_debug("Peer disconnected: %s" % id)
	CLIENT_ID = -1

func close_multiplayer():
	SERVER.close()
	multiplayer.multiplayer_peer = null
	_reset_multiplayer_state()
	print_debug("Server closed.")

func connect_server_signals():
	multiplayer.peer_connected.connect(_on_peer_connect)
	multiplayer.peer_disconnected.connect(_on_peer_disconnect)

func create_server() -> int:
	var port = randi_range(1024, 65535)
	var error := SERVER.create_server(port, 1)
	if error != OK:
		push_error("Could not create server: %s" % error)
		return -1
	
	self.PORT = port
	self.IS_MULTIPLAYER = true
	self.IS_HOST = true
	self.multiplayer.multiplayer_peer = SERVER
	self.connect_server_signals()
	print_debug("Created server on port %s" % self.PORT)
	return self.PORT

func join_server(port: int) -> bool:
	var error := self.SERVER.create_client(self.HOST, port)
	if error != OK:
		push_error("Could not join server: %s" % error)
		self._reset_multiplayer_state()
		return false
	
	self.PORT = port
	self.IS_MULTIPLAYER = true
	self.IS_CLIENT = true
	self.multiplayer.multiplayer_peer = SERVER
	print_debug("Connected to server on port %s" % PORT)
	return true

func include_node_in_network(node: Node):
	node.multiplayer.multiplayer_peer = SERVER

func remove_node_from_network(client_node: Node):
	client_node.multiplayer.multiplayer_peer = null
	print_debug("Disconnected '%s' from server" % client_node.name)
