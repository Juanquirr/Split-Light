extends Node2D

@onready var player1 = $Player1
@onready var player_switch_manager = $PlayerSwitchManager
@onready var label = $Count

func _on_teleported_left(body):
	if body == $Player1:
		$key.disable_level_visibility()
		$key.make_invisible()
		$Count.sub_count()

func _on_teleported_right(body):
	if body == $Player1:
		$key.disable_level_visibility()
		$key.make_invisible()
		$Count.add_count()

func _count_number_reached():
	$key.enable_level_visibility()
	$key.make_visible()
