extends PlayerSwitchManager


func _ready() -> void:
	await get_tree().process_frame
	
	MultiplayerManager.IS_MULTIPLAYER = false
	player1 = $"../Player1"
	player2 = $"../Player2"

	player2.is_active = true
