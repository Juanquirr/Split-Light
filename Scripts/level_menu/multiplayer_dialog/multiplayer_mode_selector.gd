extends Control

class_name MultiplayerDialog

@export var target_scene: SceneManager.GameScenes

@onready var gamemode_selector: Control = $GamemodeSelectorDialog
@onready var multiplayer_dialog: Control = $MultiplayerConfigDialog
@onready var joinroom_dialog = $JoinRoomDialog
@onready var hostroom_dialog = $HostRoomDialog

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		self.queue_free()

func on_singleplayer():
	SceneManager.change_to_scene(target_scene)
	
func on_multiplayer():
	self.gamemode_selector.visible = false
	self.multiplayer_dialog.visible = true
	
func on_host():
	self.multiplayer_dialog.visible = false
	self.hostroom_dialog.visible = true
	
func on_join():
	self.multiplayer_dialog.visible = false
	self.joinroom_dialog.visible = true

func on_cancel():
	self.queue_free()
