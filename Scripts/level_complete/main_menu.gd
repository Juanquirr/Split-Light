extends TextureButton

func _on_pressed():
	if MultiplayerManager.IS_MULTIPLAYER:
		if MultiplayerManager.IS_CLIENT:
			MultiplayerManager.disconnect_from_server()
		elif MultiplayerManager.IS_HOST:
			MultiplayerManager.close_multiplayer()
	
	SceneManager.change_to_scene(SceneManager.GameScenes.MAIN_MENU)
