extends TextureButton

@onready var ConfirmQuitScreen = $"../ConfirmQuitScreen"

func _ready():
	ConfirmQuitScreen.hide()

func _on_play_button_pressed():
	SceneManager.change_to_scene(SceneManager.SCENES.LEVEL_1)

func _on_options_button_pressed():
	push_warning("Options button has been pressed - Not implemented.")

func _on_quit_button_pressed():
	ConfirmQuitScreen.show()

func _on_quit_cancel_button_pressed():
	ConfirmQuitScreen.hide()
	
func _on_quit_confirm_button_pressed():
	get_tree().quit()
