extends Door

func _ready() -> void:
	init( SceneManager.SCENES.LEVEL_1_COMPLETED, $"../key")
