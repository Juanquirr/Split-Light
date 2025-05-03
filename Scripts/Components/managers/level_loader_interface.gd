extends TextureButton

class_name LevelLoaderController

@export var planet_info_box: Control
@export var target_scene: SceneManager.GameScenes

func _ready() -> void:
	self.planet_info_box.visible = false

func load_level():
	SceneManager.change_to_scene(target_scene)

func on_mouse_hover_entered():
	self.planet_info_box.visible = true

func on_mouse_hover_exit():
	self.planet_info_box.visible = false
