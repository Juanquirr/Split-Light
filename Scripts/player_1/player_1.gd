extends CharacterBody2D

const SPEED = 1000
const JUMP_VELOCITY = -400
const GRAVITY = 500

@onready var sprite = $Movement

func _physics_process(delta):

	# Aplicar gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	var direction = 0

	if Input.is_action_pressed("move_right"):
		direction += 1
		sprite.flip_h = false
	if Input.is_action_pressed("move_left"):
		direction -= 1
		sprite.flip_h = true

	velocity.x = direction * SPEED

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Cambio de animaciones
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0 and is_on_floor():
		sprite.play("run")
	else:
		sprite.play("idle")

	move_and_slide()
