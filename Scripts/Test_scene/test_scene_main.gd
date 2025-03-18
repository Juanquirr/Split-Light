extends Node2D

@onready var first_player_perspective_manager: Array[Player_perspective_manager] = [$ClueFirstPlayer.visibility]
@onready var second_player_perspective_manager: Array[Player_perspective_manager] = [$ClueSecondPlayer.visibility]


func _ready() -> void:
	$CharacterSwitchManager.set_perspective_managers_list(first_player_perspective_manager,second_player_perspective_manager)
	
