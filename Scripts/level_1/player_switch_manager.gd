extends PlayerSwitchManager

func _ready() -> void:
	await get_tree().process_frame 
	player1 = $"../Player1"
	player2 = $"../Player2"
	player1_perspective_manager = [$"../Count".visibility, $"../Area2D".visibility_black_poem, $"../key".interaction_manager]
	player2_perspective_manager = [$"../Area2D".visibility_red_poem]
	super._ready()
