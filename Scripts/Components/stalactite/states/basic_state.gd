class_name ResetPositionState extends State

@export var wait_time: float = 2.0
@export var next_state_name: String = "fallingstate"

var initial_position: Vector2 = Vector2.ZERO
var timer: float = 0.0
var parent: RigidBody2D
var original_position := Vector2.ZERO

func _ready() -> void:
	# Obtener el nodo abuelo, asegurándonos de que sea un RigidBody2D
	parent = get_parent().get_parent()
	original_position = $"../../stalactite_sprite".position
	if parent is RigidBody2D:
		initial_position = parent.global_position
	else:
		push_error("Parent is not a RigidBody2D")

func enter() -> void:
	timer = 0.0
	if parent:
		parent.freeze = true
		parent.global_position = initial_position

		

func exit() -> void:
	if parent:
		# Descongelar el RigidBody al salir del estado
		parent.freeze = false

func update() -> void:
	parent.global_position = initial_position

func physics_update() -> void:
	timer += get_physics_process_delta_time()
	var sprite = $"../../stalactite_sprite"

	if timer >= wait_time * 0.5 and timer < wait_time:
		var shake_strength = 2.0
		sprite.position.x = original_position.x + randf_range(-shake_strength, shake_strength)
	else:
		sprite.position = original_position
		
	if timer >= wait_time:
		sprite.position = original_position
		emit_signal("Transitioned", self, next_state_name)
