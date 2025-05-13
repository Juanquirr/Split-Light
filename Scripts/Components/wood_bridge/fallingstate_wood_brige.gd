extends State


@export var next_state_name := "hittingstate"
var parent

func _ready() -> void:
	parent = get_parent().get_parent()
	

func enter() -> void:
	if parent:
		parent.freeze  = false
		parent.linear_velocity  = Vector2.ZERO
		parent.angular_velocity   = 0.0

func exit() -> void:
	pass

func update() -> void:
	pass

func physics_update() -> void:
	pass


func _on_area_2d_area_entered(_area: Area2D) -> void:
	emit_signal("Transitioned", self, next_state_name)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("hit"):
		body.hit()
	emit_signal("Transitioned", self, next_state_name)
