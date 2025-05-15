extends RichTextLabel

@export var save_level_name := ""

const bbtext_template := "[font_size=18][font=res://Assets/Fonts/yoster.ttf][center]%s[/center][/font][/font_size]"

func _get_complete_status_text(completed: bool) -> String:
	const COMPLETED = "[color=#4CAF50]\nCompleted[/color]"
	const UNCOMPLETED = "[color=#F44336]\nUncompleted[/color]"
	return COMPLETED if completed else UNCOMPLETED

func _ready() -> void:
	self.bbcode_enabled = true
	var completed = SaveLoadManager.is_level_completed(save_level_name)
	var bbtext = self._get_complete_status_text(completed)
	self.text += bbtext_template % bbtext 
	
