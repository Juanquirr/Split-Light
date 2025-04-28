extends TextureButton

@onready var ConfirmQuitScreen = $"../ConfirmQuitScreen"
@onready var animation_player = get_node("../AnimationPlayer")

func _ready():
	pass

func _on_pressed() -> void:
	animation_player.play("selection_menu_animation")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "selection_menu_animation":
		SceneManager.change_to_scene(SceneManager.SCENES.LEVEL_SELECTOR)
