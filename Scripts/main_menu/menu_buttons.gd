extends TextureButton

@onready var ConfirmQuitScreen = $"../ConfirmQuitScreen"
@onready var animation_player = get_node("../AnimationPlayer")

func _ready():
	ConfirmQuitScreen.hide()

func _on_options_button_pressed():
	push_warning("Options button has been pressed - Not implemented.")

func _on_quit_button_pressed():
	ConfirmQuitScreen.show()

func _on_quit_cancel_button_pressed():
	ConfirmQuitScreen.hide()
	
func _on_quit_confirm_button_pressed():
	get_tree().quit()

func _on_pressed() -> void:
	animation_player.play("quit_button_to_top")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("entro")
	if anim_name == "quit_button_to_top":
		print("animacion?")
		SceneManager.change_to_scene(SceneManager.SCENES.LEVEL_SELECTOR)
