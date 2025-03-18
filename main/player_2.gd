extends CharacterBody2D

const SPEED = 200
const JUMP_VELOCITY = -400
const GRAVITY = 500

@onready var sprite = $AnimatedSprite2D

var fall_limit = 750

func _physics_process(delta):
	# Solo mover si este jugador es el activo en Level1
	if get_parent().active_player != self:
		velocity.x = 0
		sprite.play("idle")
		return

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

	if position.y > fall_limit:
		respawn()

	# Cambio de animaciones
	if not is_on_floor():
		sprite.play("jump")
	elif direction != 0:
		sprite.play("run")
	else:
		sprite.play("idle")

	move_and_slide()

func respawn():
	position = Vector2(0, 200)
	velocity = Vector2.ZERO
