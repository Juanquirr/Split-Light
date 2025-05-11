extends Button

@onready var ConfirmQuitScreen = $"../../ConfirmQuitScreen"
@onready var PauseMenu = $"../.."

func _on_pressed() -> void:
	ConfirmQuitScreen.show()

func _on_cancel_quit_pressed() -> void:
	ConfirmQuitScreen.hide()
	
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
@rpc("any_peer", "call_remote")
func _force_server_quit():
	if MultiplayerManager.IS_CLIENT:
		MultiplayerManager.disconnect_from_server()
	SceneManager.change_to_scene(SceneManager.GameScenes.MAIN_MENU)

func _on_confirm_quit_pressed() -> void:
	PauseMenu.unpause()
	
	if MultiplayerManager.IS_MULTIPLAYER:
		if MultiplayerManager.IS_CLIENT:
			MultiplayerManager.disconnect_from_server()
		elif MultiplayerManager.IS_HOST:
			_force_server_quit.rpc_id(MultiplayerManager.CLIENT_ID)
			await wait(0.25)
			MultiplayerManager.close_multiplayer()
	
	SceneManager.change_to_scene(SceneManager.GameScenes.MAIN_MENU)
	
