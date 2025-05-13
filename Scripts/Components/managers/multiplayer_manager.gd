extends Node

const DEFAULT_PORT = 49359

var IS_MULTIPLAYER := false
var IS_HOST := false
var IS_CLIENT := false
var HOST := "localhost"
var PORT := -1
var CLIENT_ID := -1

var SERVER: ENetMultiplayerPeer = ENetMultiplayerPeer.new()

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connect)
	multiplayer.peer_disconnected.connect(_on_peer_disconnect)

func _debug_print_state():
	print("IS MULTIPLAYER: %s" % IS_MULTIPLAYER)
	print("IS HOST: %s" % IS_HOST)
	print("SELF ID: %s" % multiplayer.get_unique_id())
	print("IS CLIENT: %s" % IS_CLIENT)
	print("CLIENT ID: %s" % CLIENT_ID)
	print("PORT: %s" % PORT)

func _reset_multiplayer_state():
	self.IS_MULTIPLAYER = false
	self.IS_HOST = false
	self.IS_CLIENT = false
	self.CLIENT_ID = -1

func _on_peer_connect(id: int):
	if not MultiplayerManager.IS_HOST: return
	print_debug("Peer connected: %s" % id)
	self.CLIENT_ID = id

func _on_peer_disconnect(id: int):
	if not MultiplayerManager.IS_HOST: return
	print_debug("Peer disconnected: %s" % id)
	self.CLIENT_ID = -1
	
func _get_local_ipv4() -> String:
	var interfaces = IP.get_local_interfaces()
	for interface in interfaces:
		for address in interface["addresses"]:
			if address is String and address != "127.0.0.1" and address.find(":") == -1:
				return address
	
	return "127.0.0.1"

func _resolve_host_ip() -> String:
	self.HOST = _get_local_ipv4()
	return self.HOST

func close_multiplayer():
	self.SERVER.close()
	multiplayer.multiplayer_peer = null
	self._reset_multiplayer_state()
	print_debug("Server closed.")

func create_server(server_ip: String, server_port: int) -> int:
	self.SERVER.set_bind_ip(server_ip)
	var error := self.SERVER.create_server(server_port, 1)
	if error != OK:
		push_error("Could not create server: %s" % error)
		self._reset_multiplayer_state()
		return -1
	
	self.IS_MULTIPLAYER = true
	self.IS_HOST = true
	self.HOST = server_ip
	self.PORT = server_port
	multiplayer.multiplayer_peer = self.SERVER
	print_debug("Created server on port %s" % self.PORT)
	return self.PORT

func join_server(server_address: String, server_port: int) -> bool:
	var error := self.SERVER.create_client(server_address, server_port)
	if error != OK:
		push_error("Could not join server: %s" % error)
		self._reset_multiplayer_state()
		return false
	
	self.IS_MULTIPLAYER = true
	self.HOST = server_address
	self.PORT = server_port
	self.IS_CLIENT = true
	multiplayer.multiplayer_peer = self.SERVER
	self.CLIENT_ID = multiplayer.get_unique_id()
	print_debug("Connected to server on port %s" % self.PORT)
	return true
	
func disconnect_from_server() -> bool:
	if not IS_CLIENT:
		print_debug("Not a client, cannot disconnect.")
		return false
	
	self.SERVER.close()
	multiplayer.multiplayer_peer = null
	self._reset_multiplayer_state()
	print_debug("Disconnected from server.")
	return true
