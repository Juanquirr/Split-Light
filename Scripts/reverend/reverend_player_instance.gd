extends PlayerInstance

class_name ReverendPlayerInstance

func _ready() -> void:
	self.SPEED = 300
	self.JUMP_VELOCITY = -300
	self.GRAVITY = 1000
	
	configure_multiplayer()
	configure_as_client()

func animation_process():
	if not is_on_floor():
		self.animated_sprite.play("reverend_jump")
	elif direction != 0 and is_on_floor():
		self.animated_sprite.play("reverend_walk")
		AudioManagerInstance.create_variant_audio(VariantSoundEffect.VARIANT_SOUND_EFFECT_TYPE.ON_STONE_WALK)
	else:
		self.animated_sprite.play("reverend_idle")
