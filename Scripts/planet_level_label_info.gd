extends RichTextLabel

@export var save_level_name := ""

const bbtext_template := "[font_size=18][font=res://Assets/Fonts/yoster.ttf][center]%s[/center][/font][/font_size]"

func _get_complete_status_text(completed: bool) -> String:
	var COMPLETED = get_completed_text()
	const UNCOMPLETED = "[color=#F44336]\n\nUncompleted[/color]"
	return COMPLETED if completed else UNCOMPLETED

func _ready() -> void:
	self.bbcode_enabled = true
	var completed = SaveLoadManager.is_level_completed(save_level_name)
	var bbtext = self._get_complete_status_text(completed)
	self.text += bbtext_template % bbtext 
	
func get_completed_text() -> String:
	return "[color=#4CAF50]\nCompleted[/color]\n[color=#4CAF50]Best Time: %s[/color]" % SaveLoadManager.get_level_time(save_level_name)
