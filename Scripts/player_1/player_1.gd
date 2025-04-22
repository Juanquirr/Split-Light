extends CharacterBody2D

const SPEED = 650
const JUMP_VELOCITY = -600
const GRAVITY = 900

@onready var sprite = $Movement
@onready var is_active = false
@onready var direction = 0

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if is_active:
		direction = 0
		if InputManager.is_action_pressed("move_right"):
			direction = 1
			sprite.flip_h = false
		if InputManager.is_action_pressed("move_left"):
			direction = -1
			sprite.flip_h = true
		velocity.x = direction * SPEED
		if InputManager.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		velocity.x = 0
		direction = 0

	if not is_on_floor():
		sprite.play("main_jump")
	elif direction != 0 and is_on_floor():
		sprite.play("main_run")
	else:
		sprite.play("main_idle")

	move_and_slide()

func is_active_player() -> bool:
	return is_active
