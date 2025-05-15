extends TextureButton

class_name LevelLoaderController

@export var planet_info_box: Control
@export var target_scene: SceneManager.GameScenes
@export var level_active := true
var multiplayer_config_dialog := preload("res://Scenes/multiplayer_mode_selector.tscn");


func _ready() -> void:
	self.planet_info_box.visible = false


func load_level():
	if not self.level_active: return
	var dialog: MultiplayerDialog = multiplayer_config_dialog.instantiate()
	dialog.target_scene = self.target_scene
	$"../../MultiplayerDialogHolder".add_child(dialog)
	dialog.global_position = Vector2(0,0)

func on_mouse_hover_entered():
	self.planet_info_box.visible = true

func on_mouse_hover_exit():
	self.planet_info_box.visible = false
