extends AnimatedSprite2D

@export var prevent_level := ""
@export var level_button: BaseButton

func _ready() -> void:
	if not SaveLoadManager.is_level_completed(prevent_level):
		self.modulate =  Color(0, 0, 0, 1)
		level_button.level_active = false
		
