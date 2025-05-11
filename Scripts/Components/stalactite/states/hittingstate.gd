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
	sprite = get_node("../../stalactite_sprite")
	
func enter() -> void:
	
	if parent:
		parent.freeze = true
		parent.linear_velocity = Vector2.ZERO
		parent.angular_velocity = 0.0

		if parent is RigidBody2D:
			initial_position = parent.global_position
		else:
			push_error("Parent no es RigidBody2D")

		timer = 0.0
		fading = false

	if sprite and sprite is CanvasItem:
		sprite.modulate = Color(1, 1, 1, 1.0)

func exit() -> void:
	if sprite and sprite is CanvasItem:
		sprite.modulate = Color(1, 1, 1, 1.0)

func update() -> void:
	if initial_position != null:
		parent.global_position = initial_position

	if not fading:
		timer += get_process_delta_time()
		if timer >= 0.5:
			fading = true
			timer = 0.0
	else:
		timer += get_process_delta_time()
		var alpha = clamp(1.0 - (timer / fade_duration), 0.0, 1.0)

		if sprite and sprite is CanvasItem:
			var color = sprite.modulate
			color.a = alpha
			sprite.modulate = color

		if alpha <= 0.0:
			emit_signal("Transitioned", self, next_state_name)

func physics_update() -> void:
	pass
