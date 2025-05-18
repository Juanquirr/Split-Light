extends Node2D

func _ready() -> void:
	BackgroundAudioManagerInstance.play_bg_music(BackgroundAudio.BACKGROUND_AUDIO_TYPE.LEVEL_2_THEME)
