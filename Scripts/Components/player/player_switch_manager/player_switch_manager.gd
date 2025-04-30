extends Node2D

class_name PlayerSwitchManager

var active_player: CharacterBody2D  
@onready var player1 = null
@onready var player1_perspective_manager: Array[Player_perspective_manager] = []
@onready var player2 = null
@onready var player2_perspective_manager: Array[Player_perspective_manager] = []

signal player_changed(active_player)

func _ready() -> void:
	setup_initial_players()

func setup_initial_players():
	set_active_player(player1)
	disable_movement_player(player2)
	disable_clues(player2)
	emit_signal("player_changed", active_player)

func _process(_delta: float):
	if InputManager.is_action_just_pressed("switch_player") && player1 != null && player2 != null: 
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
		emit_signal("player_changed", active_player)
