extends State

@export var next_state_name := "basicstate"

var parent
var sprite = null  
var initial_position = null
var timer := 0.0
var fading := false
@export var fade_duration := 0.2 

func _ready() -> void:
	parent = get_parent().get_parent()
	sprite = $"../../Sprite2D"
	
func enter() -> void:
	
	if parent:
		parent.freeze = true
		parent.linear_velocity = Vector2.ZERO
		parent.angular_velocity = 0.0
		initial_position = parent.global_position



func exit() -> void:
	pass

func update() -> void:
	return

func physics_update() -> void:
	pass
