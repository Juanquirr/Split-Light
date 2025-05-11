extends RichTextLabel

@export var level_name :=""

func _ready() -> void:
	bbcode_enabled = true
	if SaveLoadManager.is_level_completed(level_name):
		text += "[font_size=18][font=res://Assets/Fonts/yoster.ttf][center][color=#4CAF50]\nCompleted[/color][/center][/font][/font_size]"
	else:
		text += "[font_size=18][font=res://Assets/Fonts/yoster.ttf][center][color=#F44336]\nUncompleted[/color][/center][/font][/font_size]"
	
