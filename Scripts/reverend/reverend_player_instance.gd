extends PlayerInstance

class_name ReverendPlayerInstance

var is_on_wood = false

func _ready() -> void:
	self.SPEED = 300
	self.JUMP_VELOCITY = -300
	self.GRAVITY = 1000
	
	configure_multiplayer()
	configure_as_client()
	
func _process_jump() -> bool:
	var processed = super._process_jump()
	if not processed: return false
	AudioManagerInstance.create_variant_audio(VariantSoundEffect.VARIANT_SOUND_EFFECT_TYPE.ON_REVEREND_JUMP)
	return true
	
func sound_process() -> void:
	is_on_wood = false
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "WoodBridge":
			is_on_wood = true
	
	if self.direction != 0 and is_on_floor():
		if !is_on_wood:
			AudioManagerInstance.create_variant_audio(VariantSoundEffect.VARIANT_SOUND_EFFECT_TYPE.ON_STONE_WALK)
		else:
			AudioManagerInstance.create_variant_audio(VariantSoundEffect.VARIANT_SOUND_EFFECT_TYPE.ON_WOOD_WALK)

func animation_process():
	if not is_on_floor():
		self.animated_sprite.play("reverend_jump")
	elif direction != 0 and is_on_floor():
		self.animated_sprite.play("reverend_walk")
	else:
		self.animated_sprite.play("reverend_idle")
