extends CharacterBody2D

class_name PlayerInstance

@export var SPEED := 650
@export var JUMP_VELOCITY := -600
@export var GRAVITY := 900
@export var MAX_AIR_TIME := 1.6
@export var die_scene: SceneManager.GameScenes

@export var animated_sprite: AnimatedSprite2D = null
@export var is_active := true
@export var direction: int = 0

var _warned_no_animation_attached := false
var _warned_empty_animation := false
var _air_time := 0.0

var _current_scene_name := ""

func is_active_player() -> bool:
	return is_active
	
func animation_process() -> void:
	if self.animated_sprite == null and not self._warned_no_animation_attached: 
		push_warning(self.name + " node instance doesn't have an AnimationSprite2D instance attached.")
		self._warned_no_animation_attached = true
		return
	
	if not self._warned_empty_animation and self.animated_sprite != null:
		push_warning(self.name + " node instance doesn't have an animation playing.")
		self._warned_empty_animation = true
		
func sound_process() -> void:
	pass

func configure_multiplayer():
	if not MultiplayerManager.IS_MULTIPLAYER: return
	multiplayer.multiplayer_peer = MultiplayerManager.SERVER
	
func configure_as_client():
	if not MultiplayerManager.IS_MULTIPLAYER: return
	set_multiplayer_authority(MultiplayerManager.CLIENT_ID, true)
		
func _process_move_right():
	if not InputManager.is_action_pressed("move_right"): return
	self.direction = 1
	self.animated_sprite.flip_h = false

func _process_move_left():
	if not InputManager.is_action_pressed("move_left"): return
	self.direction = -1
	self.animated_sprite.flip_h = true

func _process_jump() -> bool:
	if not (InputManager.is_action_pressed("jump") and is_on_floor()): return false
	self.velocity.y = JUMP_VELOCITY
	return true
	
func _process_movement():
	self._process_move_right()
	self._process_move_left()
	self.velocity.x = direction * SPEED
	
func _process_vertical_gravity(delta: float):
	if is_on_floor(): return
	self.velocity.y += GRAVITY * delta
	
func _client_handles_authority():
	if not MultiplayerManager.IS_MULTIPLAYER: return true
	return is_multiplayer_authority()
	
func _ready() -> void:
	var scene_path = get_tree().current_scene.scene_file_path
	self._current_scene_name = scene_path.get_file().get_basename()
	
func _process(_delta: float) -> void:
	self.animation_process()
	self.sound_process()
	
func _physics_process(delta: float):
	self._process_vertical_gravity(delta)
	
	if is_on_floor() and  _air_time < MAX_AIR_TIME:
		_air_time = 0.0
	else:
		_air_time += delta
		if _air_time > MAX_AIR_TIME and is_on_floor():
			die()
	
	if self.is_active and self._client_handles_authority():
		self.direction = 0
		self._process_movement()
		self._process_jump()
	elif is_on_floor():
		self.velocity.x = 0
		self.direction = 0

	move_and_slide()

@rpc("any_peer", "call_local")
func die():
	SceneManager.change_to_scene(die_scene)
