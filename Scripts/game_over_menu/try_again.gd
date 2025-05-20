extends TextureButton

@export var target_scene: SceneManager.GameScenes

func _ready() -> void:
	BackgroundAudioManagerInstance.stop_active_audio()

@rpc("any_peer", "call_local")
func on_try_again():
	SceneManager.change_to_scene(target_scene)

func _on_pressed():
	on_try_again.rpc()
