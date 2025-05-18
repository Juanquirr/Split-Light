extends Node

@onready var bg_music_slider: HSlider = $SliderEntry/BGMusicSlider
@onready var sfx_slider: HSlider = $SliderEntry2/SFXSlider

func _ready() -> void:
	bg_music_slider.value = SaveLoadManager.get_bg_music_audio_level()
	sfx_slider.value = SaveLoadManager.get_sfx_audio_level()
	
func _on_bg_music_drag(value: float):
	SaveLoadManager.save_bg_music_audio_level(int(value))
	BackgroundAudioManagerInstance.update_global_audio_volume()

func _on_sfx_drag(value: float):
	SaveLoadManager.save_sfx_audio_level(int(value))
