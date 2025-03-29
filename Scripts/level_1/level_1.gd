extends Node2D

@onready var player1_perspective_manager: Array[Player_perspective_manager] = [$Count.visibility, $Area2D.visibility_black_poem, $key.interaction_manager ]
@onready var player2_perspective_manager: Array[Player_perspective_manager] = [$Area2D.visibility_red_poem]

@onready var player1 = $Player1

@onready var player_switch_manager = $PlayerSwitchManager
@onready var label = $Count

func _ready():
	await get_tree().process_frame 
	$Teleporter_left.init($Teleporter_right, $Teleporter_left.exit_direction.RIGHT )
	$Teleporter_right.init($Teleporter_left,$Teleporter_right.exit_direction.LEFT )
	$Count.set_count(3)
	$Teleporter_left.connect("teleported", Callable(self, "_on_teleported_left"))
	$Teleporter_right.connect("teleported", Callable(self, "_on_teleported_right"))
	$Count.connect("number_reached", Callable(self, "_number_reached"))
	$Count.set_reach_number(0)
	$key.init(false,false,false)
	player_switch_manager.set_perspective_managers_list(player1_perspective_manager, player2_perspective_manager)
	

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

func _number_reached():
	$key.enable_level_visibility()
	$key.make_visible()