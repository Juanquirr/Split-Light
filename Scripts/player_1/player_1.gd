extends CharacterBody2D

signal count_changed(new_count)

const SPEED = 650
const JUMP_VELOCITY = -600
const GRAVITY = 900
@export var LEFT_LIMIT = 600
@export var RIGHT_LIMIT = 3750

@onready var sprite = $Movement
@onready var is_active  = false
@onready var direction = 0
var count = 3

func _physics_process(delta):
	

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if is_active:
		direction = 0
		if Input.is_action_pressed("move_right"):
			direction = 1
			sprite.flip_h = false
		if Input.is_action_pressed("move_left"):
			direction = -1
			sprite.flip_h = true
		velocity.x = direction * SPEED
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		velocity.x = 0
		direction = 0

	

	# Cambio de animaciones
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0 and is_on_floor():
		sprite.play("run")
	else:
		sprite.play("idle")

	move_and_slide()
	
	if global_position.x > RIGHT_LIMIT:
		global_position.x = 600
		count = count + 1
		emit_signal("count_changed", count)
		
	if global_position.x < LEFT_LIMIT:
		global_position.x = 3750
		count = count - 1
		emit_signal("count_changed", count)
