extends TextureButton

func _on_pressed():
	SceneManager.change_to_scene(SceneManager.GameScenes.MAIN_MENU)
