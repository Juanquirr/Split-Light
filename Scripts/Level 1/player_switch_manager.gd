extends PlayerSwitchManager


func _ready() -> void:
	await get_tree().process_frame
	
	player1 = $"../Player1"
	player2 = $"../Player2"
	
	player1_perspective_manager = [
		$"../../Mechanisms/Count".visibility, 
		$"../../Mechanisms/Area2D".visibility_black_poem, 
		$"../../Mechanisms/key".interaction_manager
	]
	player2_perspective_manager = [$"../../Mechanisms/Area2D".visibility_red_poem]
	
	if MultiplayerManager.IS_MULTIPLAYER and MultiplayerManager.IS_CLIENT:
		set_active_player(player2)
		disable_movement_player(player1)
		disable_clues(player1)
		emit_signal("player_changed", active_player)
	else:
		super._ready()
