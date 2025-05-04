extends Button

@onready var PauseMenu = $"../.."

func _on_pressed() -> void:
	PauseMenu.unpause()
	SceneManager.change_to_scene(SceneManager.SCENES.)	
	
