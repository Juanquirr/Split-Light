extends Node2D

var active_player: CharacterBody2D  
@onready var player1 = get_node("../Player1")
@onready var player1_perspective_manager: Array[Player_perspective_manager] = []
@onready var player2 = get_node("../Player2")
@onready var player2_perspective_manager: Array[Player_perspective_manager] = []

func set_perspective_managers_list(new_first_list: Array, new_second_list: Array) -> void:
	player1_perspective_manager = new_first_list
	player2_perspective_manager = new_second_list
	reload_perpectives()

func reload_perpectives():
	if active_player == player1:
		set_active_player(player1)
		disable_movement_player(player2)
		disable_clues(player2)
	else:
		set_active_player(player2)
		disable_movement_player(player1)
		disable_clues(player1)

func _ready():
	set_active_player(player1)  
	disable_movement_player(player2)
	disable_clues(player2)



func _input(event):
	if event.is_action_pressed("switch_player"):  
		if active_player == player1:
			change_active_player(player2)
		else:
			change_active_player(player1)

func disable_movement_player(player: CharacterBody2D):
		player.set_process_input(false)
		player.is_active = false
		

func enable_movement_player(player: CharacterBody2D):
		player.set_process_input(true)
		player.is_active = true
		

func disable_clues(player: CharacterBody2D):
	if player == player1:
		for clue in player1_perspective_manager:
			clue.disable()
	else:
		for clue in player2_perspective_manager:
			clue.disable()

func enable_clues(player: CharacterBody2D):
	if player == player1:
		for clue in player1_perspective_manager:
			clue.enable()
	else:
		for clue in player2_perspective_manager:
			clue.enable()
			
func unset_active_player():
	disable_movement_player(active_player)
	disable_clues(active_player)
	active_player = null

func set_active_player(new_player: CharacterBody2D):
	enable_movement_player(new_player)
	enable_clues(new_player)
	new_player.get_node("Camera2D").make_current()
	active_player = new_player
	
	
	
func change_active_player(new_player: CharacterBody2D):
	if active_player:
		unset_active_player()
		set_active_player(new_player)
		
