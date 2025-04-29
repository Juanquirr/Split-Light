extends CharacterBody2D

class_name PlayerInstance

@export var SPEED = 650
@export var JUMP_VELOCITY = -600
@export var GRAVITY = 900

@export var animated_sprite: AnimatedSprite2D = null
@export var is_active = false
@export var direction = 0

var _warned_empty_animation = false

func is_active_player() -> bool:
	return is_active
	
func animation_process():
	if self.animated_sprite == null: return
	
	if not self._warned_empty_animation:
		push_warning(self.name + " node instance doesn't have an animation playing.")
		self._warned_empty_animation = true
	
func _physics_process(delta: float):
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	if self.is_active:
		self.direction = 0
		if InputManager.is_action_pressed("move_right"):
			self.direction = 1
			self.animated_sprite.flip_h = false
		if InputManager.is_action_pressed("move_left"):
			self.direction = -1
			self.animated_sprite.flip_h = true
		self.velocity.x = direction * SPEED
		if InputManager.is_action_just_pressed("jump") and is_on_floor():
			self.velocity.y = JUMP_VELOCITY
	elif is_on_floor():
		self.velocity.x = 0
		self.direction = 0

	animation_process()
	move_and_slide()
