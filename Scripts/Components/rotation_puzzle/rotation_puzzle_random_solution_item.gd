extends Sprite2D

var sprite_rotation := 0.0

func rotate_90_degrees() -> void:
	sprite_rotation += 90
	rotation_degrees = sprite_rotation
	get_parent().on_child_changed(self)

func rotate_90_degrees_silent() -> void:
	sprite_rotation += 90
	rotation_degrees = sprite_rotation
