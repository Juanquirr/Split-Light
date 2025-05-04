extends Button

@onready var ConfirmQuitScreen = $"../../ConfirmQuitScreen"
@onready var PauseMenu = $"../.."

func _on_pressed() -> void:
	ConfirmQuitScreen.show()

func _on_cancel_quit_pressed() -> void:
	ConfirmQuitScreen.hide()

func _on_confirm_quit_pressed() -> void:
	PauseMenu.unpause()
	SceneManager.change_to_scene(SceneManager.GameScenes.MAIN_MENU)	
	
