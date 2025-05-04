extends PlayerInstance

func animation_process():
	if not is_on_floor():
		self.animated_sprite.play("main_jump")
	elif self.direction != 0 and is_on_floor():
		self.animated_sprite.play("main_run")
	else:
		self.animated_sprite.play("main_idle")
