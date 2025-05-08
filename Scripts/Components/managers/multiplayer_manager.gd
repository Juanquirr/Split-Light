extends Node

var IS_MULTIPLAYER := false
var IS_HOST := false
var IS_CLIENT := false
var HOST := "localhost"
var PORT := -1
var CLIENT_ID := -1

var SERVER: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

func debug_print_state():
	print("IS MULTIPLAYER: %s" % IS_MULTIPLAYER)
	print("IS HOST: %s" % IS_HOST)
	print("IS CLIENT: %s" % IS_CLIENT)
	print("PORT: %s" % PORT)
	print("CLIENT ID: %s" % CLIENT_ID)

func _reset_multiplayer_state():
	self.IS_MULTIPLAYER = false
	self.IS_HOST = false
	self.IS_CLIENT = false
	self.PORT = -1
	self.CLIENT_ID = -1

func _on_peer_connect(id: int):
	print_debug("Peer connected: %s" % id)
	self.CLIENT_ID = id

func _on_peer_disconnect(id: int):
	print_debug("Peer disconnected: %s" % id)
	self.CLIENT_ID = -1

func close_multiplayer():
	self.SERVER.close()
	multiplayer.multiplayer_peer = null
	self._reset_multiplayer_state()
	print_debug("Server closed.")

func connect_server_signals():
	multiplayer.peer_connected.connect(_on_peer_connect)
	multiplayer.peer_disconnected.connect(_on_peer_disconnect)

func create_server() -> int:
	var port = randi_range(49152, 65535)
	var error := SERVER.create_server(port, 1)
	if error != OK:
		push_error("Could not create server: %s" % error)
		return -1
	
	self.PORT = port
	self.IS_MULTIPLAYER = true
	self.IS_HOST = true
	multiplayer.multiplayer_peer = SERVER
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
	multiplayer.multiplayer_peer = SERVER
	self.CLIENT_ID = multiplayer.get_unique_id()
	print_debug("Connected to server on port %s" % PORT)
	return true
