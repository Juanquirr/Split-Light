extends Node2D

var active_player: CharacterBody2D  
@onready var first_player = get_node("../firstPlayer")
@onready var first_player_perspective_manager: Array[Player_perspective_manager] = []
@onready var second_player = get_node("../secondPlayer")
@onready var second_player_perspective_manager: Array[Player_perspective_manager] = []

func set_perspective_managers_list(new_first_list: Array, new_second_list: Array) -> void:
	first_player_perspective_manager = new_first_list
	second_player_perspective_manager = new_second_list
	reload_perpectives()

func reload_perpectives():
	if active_player == first_player:
		set_active_character(first_player)
		disable_movement_character(second_player)
		disable_clues(second_player)
	else:
		set_active_character(second_player)
		disable_movement_character(first_player)
		disable_clues(first_player)

func _ready():
	first_player.set_physics_process(true)
	second_player.set_physics_process(true)
	set_active_character(first_player)  
	disable_movement_character(second_player)
	disable_clues(second_player)



func _input(event):
	if event.is_action_pressed("switch_character"):  
		if active_player == first_player:
			change_active_character(second_player)
		else:
			change_active_character(first_player)

func disable_movement_character(character: CharacterBody2D):
		character.set_process_input(false)
		character.is_active = false
		

func enable_movement_character(character: CharacterBody2D):
		character.set_process_input(true)
		character.is_active = true
		

func disable_clues(character: CharacterBody2D):
	if character == first_player:
		for clue in first_player_perspective_manager:
			clue.disable()
	else:
		for clue in second_player_perspective_manager:
			clue.disable()

func enable_clues(character: CharacterBody2D):
	if character == first_player:
		for clue in first_player_perspective_manager:
			clue.enable()
	else:
		for clue in second_player_perspective_manager:
			clue.enable()
			
func unset_active_character():
	disable_movement_character(active_player)
	disable_clues(active_player)
	active_player = null

func set_active_character(new_character: CharacterBody2D):
	enable_movement_character(new_character)
	enable_clues(new_character)
	new_character.get_node("Camera2D").make_current()
	active_player = new_character
	
	
	
func change_active_character(new_character: CharacterBody2D):
	if active_player:
		unset_active_character()
		set_active_character(new_character)
		
