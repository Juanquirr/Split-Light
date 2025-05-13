extends State


@export var next_state_name: String = "fallingstate"

var initial_position: Vector2 = Vector2.ZERO
var parent: RigidBody2D
var original_position := Vector2.ZERO

func _ready() -> void:
	parent = get_parent().get_parent()
	original_position = $"../../Sprite2D".position
	if parent is RigidBody2D:
		initial_position = parent.global_position
	else:
		push_error("Parent is not a RigidBody2D")

func enter() -> void:
	if parent:
		parent.freeze = true
		parent.global_position = initial_position

func exit() -> void:
	if parent:
		parent.freeze = false

func update() -> void:
	parent.global_position = initial_position

func physics_update() -> void:
	pass 
	

func activate():
	var sprite = $"../../Sprite2D"
	sprite.position = original_position
	emit_signal("Transitioned", self, next_state_name)
