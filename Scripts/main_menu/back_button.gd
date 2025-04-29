extends TextureButton

func _on_pressed() -> void:
	SceneManager.change_to_scene(SceneManager.SCENES.MAIN_MENU)
