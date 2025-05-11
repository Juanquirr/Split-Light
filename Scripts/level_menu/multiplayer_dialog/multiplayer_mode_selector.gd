extends Control

class_name MultiplayerDialog

@export var target_scene: SceneManager.GameScenes

@onready var gamemode_selector: Control = $GamemodeSelectorDialog
@onready var multiplayer_dialog: Control = $MultiplayerConfigDialog
@onready var joinroom_dialog: Control = $JoinRoomDialog
@onready var hostroom_dialog: Control = $HostRoomDialog
@onready var waiting_dialog: Control = $WaitingForServerDialog
@onready var joinsuccess_dialog: Control = $ClientConnectSuccessDialog

@onready var server_serverip_input: LineEdit = $HostRoomDialog/ServerIpInput
@onready var server_serverport_input: LineEdit = $HostRoomDialog/PortInput
@onready var server_starter_btns: Control = $HostRoomDialog/ServerHandlerButtons
@onready var server_handler_btns: Control = $HostRoomDialog/ServerStarterButtons
@onready var server_start_game_btn: Button = $HostRoomDialog/ServerStarterButtons/Start
@onready var playerconnected_label: RichTextLabel = $HostRoomDialog/PlayerConnectedLabel
@onready var join_serverip_input: LineEdit = $JoinRoomDialog/ServerIpInput
@onready var join_serverport_input: LineEdit = $JoinRoomDialog/PortInput

func terminate_dialog():
	if MultiplayerManager.IS_MULTIPLAYER:
		MultiplayerManager.close_multiplayer()
	
	self.queue_free()

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		terminate_dialog()

func on_singleplayer():
	if MultiplayerManager.IS_MULTIPLAYER:
		MultiplayerManager.close_multiplayer()
	
	SceneManager.change_to_scene(target_scene)
	
func on_multiplayer():
	self.gamemode_selector.visible = false
	self.multiplayer_dialog.visible = true
	
func on_host():
	self.multiplayer_dialog.visible = false
	
	server_serverip_input.text = MultiplayerManager._resolve_host_ip()
	server_serverport_input.text = str(MultiplayerManager.DEFAULT_PORT)
	
	self.hostroom_dialog.visible = true
	
func on_host_start_server():
	var ip := server_serverip_input.text
	var port := int(server_serverport_input.text)
	var success := MultiplayerManager.create_server(ip, port)
	if success < 0:
		push_error("Error when creating server")
		return
		
	server_starter_btns.visible = false
	server_handler_btns.visible = true
	
@rpc("any_peer", "call_remote")
func show_player_connected():
	self.playerconnected_label.visible = true
	self.server_start_game_btn.disabled = false
	on_join_success.rpc_id(MultiplayerManager.CLIENT_ID)
	
func on_join():
	self.multiplayer_dialog.visible = false
	self.joinroom_dialog.visible = true
	
func on_join_start():
	self.joinroom_dialog.visible = false
	self.waiting_dialog.visible = true
	
	var address := join_serverip_input.text
	var port := int(join_serverport_input.text)
	
	if address == "" or (port < 1024 and port > 65535):
		return
	
	var success := MultiplayerManager.join_server(address, port)
	if not success:
		var server = "%s:%s" % [join_serverip_input.text, join_serverport_input.text]
		push_error("Failed to connect to server at %s" % server)
		self.waiting_dialog.visible = false
		self.joinroom_dialog.visible = true
		return
	
	# Connect the signal to wait for successful connection
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)

func _on_connected_to_server():
	# Now that the client is connected, send the RPC to the server
	show_player_connected.rpc_id(1)
	multiplayer.connected_to_server.disconnect(_on_connected_to_server)
	multiplayer.connection_failed.disconnect(_on_connection_failed)

func _on_connection_failed():
	var server = "%s:%s" % [join_serverip_input.text, join_serverport_input.text]
	push_error("Failed to connect to server at %s" % server)
	self.waiting_dialog.visible = false
	self.joinroom_dialog.visible = true
	multiplayer.connected_to_server.disconnect(_on_connected_to_server)
	multiplayer.connection_failed.disconnect(_on_connection_failed)

func on_cancel():
	terminate_dialog()
	
func on_start_host():
	host_start.rpc()
	SceneManager.change_to_scene(self.target_scene)
	
@rpc("authority", "call_remote")
func host_start():
	SceneManager.change_to_scene(self.target_scene)

@rpc("any_peer", "call_remote")
func on_join_success():
	self.waiting_dialog.visible = false
	self.joinsuccess_dialog.visible = true
