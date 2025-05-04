extends CharacterBody2D

class_name PlayerInstance

@export var SPEED = 650
@export var JUMP_VELOCITY = -600
@export var GRAVITY = 900

@export var animated_sprite: AnimatedSprite2D = null
@export var is_active = false
@export var direction = 0

var _warned_no_animation_attached = false
var _warned_empty_animation = false

func is_active_player() -> bool:
	return is_active
	
func animation_process():
	if self.animated_sprite == null and not self._warned_no_animation_attached: 
		push_warning(self.name + " node instance doesn't have an AnimationSprite2D instance attached.")
		self._warned_no_animation_attached = true
		return
	
	if not self._warned_empty_animation and self.animated_sprite != null:
		push_warning(self.name + " node instance doesn't have an animation playing.")
		self._warned_empty_animation = true
		
func _process_move_right():
	if not InputManager.is_action_pressed("move_right"): return
	self.direction = 1
	self.animated_sprite.flip_h = false

func _process_move_left():
	if not InputManager.is_action_pressed("move_left"): return
	self.direction = -1
	self.animated_sprite.flip_h = true

func _process_jump():
	if not (InputManager.is_action_pressed("jump") and is_on_floor()): return
	self.velocity.y = JUMP_VELOCITY
	
func _process_movement():
	self._process_move_right()
	self._process_move_left()
	self.velocity.x = direction * SPEED
	
func _process_vertical_gravity(delta: float):
	if is_on_floor(): return
	self.velocity.y += GRAVITY * delta
	
func _physics_process(delta: float):
	self._process_vertical_gravity(delta)	
	
	if self.is_active:
		self.direction = 0
		self._process_movement()
		self._process_jump()
	elif is_on_floor():
		self.velocity.x = 0
		self.direction = 0		

	self.animation_process()
	move_and_slide()
