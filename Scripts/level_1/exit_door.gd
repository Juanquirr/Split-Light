extends Door

signal level_end()

func _ready() -> void:
	init( SceneManager.SCENES.LEVEL_1_COMPLETED, $"../key")

func _process(_delta):
	if InputManager.is_action_just_pressed("Interact"):
		for player in players_inside:
				if player.is_active_player() && (key == null || key.get_key_status()):
					emit_signal("level_end")
					SceneManager.change_to_scene(self.target_scene)
