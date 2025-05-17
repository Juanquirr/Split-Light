extends Control

@onready var animation_player = $SelectionLevelAnimation

func _ready() -> void:
	animation_player.current_animation = "selection_menu_animation"
	animation_player.seek(animation_player.current_animation_length, true)
	animation_player.play_backwards("selection_menu_animation")
	BackgroundAudioManagerInstance.play_bg_music(BackgroundAudio.BACKGROUND_AUDIO_TYPE.MENU_THEME)
