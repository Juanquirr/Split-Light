extends Control

class_name MultiplayerDialog

@export var target_scene: SceneManager.GameScenes

@onready var gamemode_selector: Control = $GamemodeSelectorDialog
@onready var multiplayer_dialog: Control = $MultiplayerConfigDialog
@onready var joinroom_dialog: Control = $JoinRoomDialog
@onready var hostroom_dialog: Control = $HostRoomDialog
@onready var waiting_dialog: Control = $WaitingForServerDialog
@onready var joinsuccess_dialog: Control = $ClientConnectSuccessDialog

@onready var roomcode_label: RichTextLabel = $HostRoomDialog/RoomCodeLabel
@onready var playerconnected_label: RichTextLabel = $HostRoomDialog/PlayerConnectedLabel
@onready var roomcode_input: TextEdit = $JoinRoomDialog/CodeInput

const code_bbl_text := '[font_size=30][center][font="res://Assets/Fonts/yoster.ttf"]%s[/font][/center][/font_size]'

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
	var room_code = MultiplayerManager.create_server()
	if room_code < 0:
		print("Error when creating server")
		return
	
	roomcode_label.text = self.code_bbl_text % room_code
	
	self.multiplayer_dialog.visible = false
	self.hostroom_dialog.visible = true
	
@rpc("any_peer", "call_remote")
func show_player_connected():
	self.playerconnected_label.visible = true
	on_join_success.rpc_id(MultiplayerManager.CLIENT_ID)
	
func on_join():
	self.multiplayer_dialog.visible = false
	self.joinroom_dialog.visible = true
	
func on_join_start():
	self.joinroom_dialog.visible = false
	self.waiting_dialog.visible = true
	var success := MultiplayerManager.join_server(int(roomcode_input.text))
	if not success:
		push_error("Could not join server at code %s" % roomcode_input.text)
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
	push_error("Failed to connect to server at code %s" % roomcode_input.text)
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
