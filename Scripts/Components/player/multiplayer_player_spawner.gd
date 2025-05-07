extends Node

@export var host_player_scene: PackedScene  # Scene for the host's player
@export var client_player_scene: PackedScene  # Scene for the client's player
@export var player_switch_manager: PlayerSwitchManager

# Dictionary to keep track of player nodes
var players: Dictionary = {}

func _ready():
	MultiplayerManager.debug_print_state()
	# If this is the server, spawn its own player
	if MultiplayerManager.IS_HOST:
		_spawn_player(1)  # Server's peer ID is 1
	
	if MultiplayerManager.CLIENT_ID > 1:
		_spawn_player(MultiplayerManager.CLIENT_ID)

func _is_host(id: int):
	return id == 1

func _spawn_player(id: int):
	# Choose the correct scene based on whether this is the host or client
	var player_scene = host_player_scene if _is_host(id) else client_player_scene
	
	# Instance the player
	var player = player_scene.instantiate()
	
	# Set multiplayer authority to the peer ID
	player.set_multiplayer_authority(id)
	player.global_position = Vector2(617, 175)
	
	# Add to the scene tree (adjust the parent node as needed)
	add_child(player)
	
	if _is_host(id):
		player_switch_manager.player1 = player
	else:
		player_switch_manager.player2 = player
	
	# Store in the players dictionary
	players[id] = player
	print_debug("Spawned player for peer %s (is_host: %s)" % [id, id == 1])
