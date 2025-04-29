extends PlayerInstance

func animation_process():
	if not is_on_floor():
		self.animated_sprite.play("reverend_jump")
	elif direction != 0 and is_on_floor():
		self.animated_sprite.play("reverend_walk")
	else:
		self.animated_sprite.play("reverend_idle")
