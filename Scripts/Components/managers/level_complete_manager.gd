extends Control

class_name LevelCompleteManager

enum LevelNumber {
	LEVEL_1 = 1,
	LEVEL_2 = 2,
	LEVEL_3 = 3,
	LEVEL_4 = 4,
	LEVEL_5 = 5,
}

var TEXT_COMPLETE_TEMPLATE := '[font_size=90][center][font="res://Assets/Fonts/yoster.ttf"]LEVEL %s COMPLETED[/font][/center][/font_size]'

@export var total_level_time_in_seconds := 300
@export var level_number := LevelNumber.LEVEL_1

@onready var level_complete_text: RichTextLabel = $RichTextLabel

func complete_sound_manager():
	match level_number:
		1:
			AudioManagerInstance.create_audio(SoundEffect.SOUND_EFFECT_TYPE.ON_WIN_LEVEL_1)
		2:
			AudioManagerInstance.create_audio(SoundEffect.SOUND_EFFECT_TYPE.ON_WIN_LEVEL_2)

func _ready() -> void:
	self.level_complete_text.text = TEXT_COMPLETE_TEMPLATE % str(level_number)
	self.complete_sound_manager()
