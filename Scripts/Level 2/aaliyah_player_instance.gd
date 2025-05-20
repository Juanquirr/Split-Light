extends PlayerInstance

class_name AaliyahPlayerInstance

func _ready() -> void:
	self.SPEED = 650
	self.JUMP_VELOCITY = -600
	self.GRAVITY = 900

	configure_multiplayer()
	configure_as_client()
	
func sound_process() -> void:
	if self.direction != 0 and is_on_floor():
		AudioManagerInstance.create_variant_audio(VariantSoundEffect.VARIANT_SOUND_EFFECT_TYPE.ON_GRASS_WALK)

func animation_process():
	if not is_on_floor():
		self.animated_sprite.play("aaliyah_jump")
	elif self.direction != 0 and is_on_floor():
		self.animated_sprite.play("aaliyah_run")
	else:
		self.animated_sprite.play("aaliyah_idle")
