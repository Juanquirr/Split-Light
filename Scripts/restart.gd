extends Button

@onready var ConfirmRestartScreen = $"../../ConfirmRestartScreen"
@onready var PauseMenu = $"../.."

func _process(_delta: float) -> void:
	if MultiplayerManager.IS_CLIENT:
		self.disabled = true
	else:
		self.disabled = false

func _on_pressed() -> void:
	ConfirmRestartScreen.show()

func _on_cancel_quit_pressed() -> void:
	ConfirmRestartScreen.hide()

@rpc("authority", "call_local")
func restart_client():
	PauseMenu.unpause()
	BackgroundAudioManagerInstance.stop_active_audio()
	SceneManager.change_to_scene(PauseMenu.restart_level)

func _on_confirm_quit_pressed() -> void:
	restart_client.rpc()
