extends PlayerSwitchManager


func _ready() -> void:
	await get_tree().process_frame
	
	
	player1 = $"../Player1"
	player2 = $"../Player2"
	if MultiplayerManager.IS_MULTIPLAYER and MultiplayerManager.IS_CLIENT:
		set_active_player(player2)
		disable_movement_player(player1)
		disable_clues(player1)
		emit_signal("player_changed", active_player)
	else:
		super._ready()
	
