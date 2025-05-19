extends TextureButton

@export var target_scene: SceneManager.GameScenes

func _ready() -> void:
	BackgroundAudioManagerInstance.stop_active_audio()

func _on_pressed():
	SceneManager.change_to_scene(target_scene)
