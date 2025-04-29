extends TextureButton

@onready var animation_player = get_node("../../SelectionLevelAnimation")
var play_pressed := false

func _on_pressed() -> void:
	play_pressed = true
	await get_tree().process_frame
	animation_player.play("selection_menu_animation")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "selection_menu_animation" and play_pressed:
		play_pressed = false
		SceneManager.change_to_scene(SceneManager.SCENES.LEVEL_SELECTOR)
