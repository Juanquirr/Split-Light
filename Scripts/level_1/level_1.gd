extends Node2D

@onready var player1_perspective_manager: Array[Player_perspective_manager] = [$Count.visibility]
@onready var player2_perspective_manager: Array[Player_perspective_manager] = []

@onready var player1 = $Player1

@onready var player_switch_manager = $PlayerSwitchManager
@onready var label = $Count

func _ready():
	await get_tree().process_frame 
	$Teleporter_left.init($Teleporter_right, $Teleporter_left.exit_direction.RIGHT )
	$Teleporter_right.init($Teleporter_left,$Teleporter_right.exit_direction.LEFT )
	player1.count_changed.connect(_on_count_changed)
	_on_count_changed(player1.count)
	player_switch_manager.set_perspective_managers_list(player1_perspective_manager, player2_perspective_manager)
	
func _on_count_changed(new_count):
	label.text = str(new_count)
