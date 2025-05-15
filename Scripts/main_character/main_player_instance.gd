extends PlayerInstance

class_name AbotPlayerInstance

func _ready() -> void:
	super._ready()
	self.SPEED = 650
	self.JUMP_VELOCITY = -600
	self.GRAVITY = 900
	
	configure_multiplayer()
	
func _process_jump() -> bool:
	var processed = super._process_jump()
	if not processed: return false
	AudioManagerInstance.create_audio(SoundEffect.SOUND_EFFECT_TYPE.ON_ABOT_JUMP)
	return true
	
func sound_process_level1():
	if self.direction != 0 and is_on_floor():
		AudioManagerInstance.create_variant_audio(VariantSoundEffect.VARIANT_SOUND_EFFECT_TYPE.ON_STONE_WALK)

func sound_process() -> void:	
	match self._current_scene_name:
		"level_1":
			sound_process_level1()

func animation_process() -> void:
	if not is_on_floor():
		self.animated_sprite.play("main_jump")
	elif self.direction != 0 and is_on_floor():
		self.animated_sprite.play("main_run")
	else:
		self.animated_sprite.play("main_idle")
