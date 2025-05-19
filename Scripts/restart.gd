extends Button

@onready var ConfirmRestartScreen = $"../../ConfirmRestartScreen"
@onready var PauseMenu = $"../.."

func _on_pressed() -> void:
	ConfirmRestartScreen.show()

func _on_cancel_quit_pressed() -> void:
	ConfirmRestartScreen.hide()

func _on_confirm_quit_pressed() -> void:
	PauseMenu.unpause()
	BackgroundAudioManagerInstance.stop_active_audio()
	SceneManager.change_to_scene(PauseMenu.restart_level)
