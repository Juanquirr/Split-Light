extends Node2D

@onready var player1: PlayerInstance = $Characters/Player1
@onready var player2: PlayerInstance = $Characters/Player2
@onready var player_switch_manager = $Characters/PlayerSwitchManager
@onready var label = $Mechanisms/Count
@onready var key = $Mechanisms/key

func _on_teleported_left(body):
	if body == player1:
		key.disable_level_visibility()
		key.make_invisible()
		label.sub_count()
	
func _on_teleported_right(body):
	if body == player1:
		key.disable_level_visibility()
		key.make_invisible()
		label.add_count()

func _count_number_reached():
	key.enable_level_visibility()
	key.make_visible()
