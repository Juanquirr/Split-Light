extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -425.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if velocity.y < 0 and not is_on_floor():
		sprite_2d.play("jumping")
	elif velocity.y > 0 and not is_on_floor() and sprite_2d.animation != "jumping":
		sprite_2d.play("on_air")

	elif is_on_floor():
		if abs(velocity.x) > 1:
			sprite_2d.play("running")
		else:
			sprite_2d.animation = "default"

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite_2d.play("jumping")
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 30)

	move_and_slide()

	if velocity.x < 0:
		sprite_2d.flip_h = 1
	if velocity.x > 0:
		sprite_2d.flip_h = 0
