extends Node2D
## Audio manager node. Inteded to be globally loaded as a 2D Scene. Handles [method create_2d_audio_at_location()] and [method create_audio()] to handle the playback and culling of simultaneous sound effects.
##
## To properly use, define [enum SoundEffect.SOUND_EFFECT_TYPE] for each unique sound effect, create a Node2D scene for this AudioManager script add those SoundEffect resources to this globally loaded script's [member sound_effects], and setup your individual SoundEffect resources. Then, use [method create_2d_audio_at_location()] and [method create_audio()] to play those sound effects either at a specific location or globally.
## 
## See https://github.com/Aarimous/AudioManager for more information.
##
## @tutorial: https://www.youtube.com/watch?v=Egf2jgET3nQ

var sound_effect_dict: Dictionary = {} ## Loads all registered SoundEffects on ready as a reference.

@export var sound_effects: Array[SoundEffect] ## Stores all possible SoundEffects that can be played.


func _ready() -> void:
	for sound_effect: SoundEffect in sound_effects:
		sound_effect_dict[sound_effect.type] = sound_effect


## Method to generate a new audio instance.
## [br]
## by skinnydevi.
## [br][br]
## - [param audio_instance]: audio from [code]AudioStreamPlayer2D[/code] or [code]AudioStreamPlayer[/code].
## [br][br]
## - [param sound_effect]: Sound effect to play.
## [br][br]
## - [param location]: [code]null[/code] or [code]Vector2[/code] of audio position. Only compatible with [code]AudioStreamPlayer2D[/code].
func _define_audio_instance(
	audio_instance: Variant, 
	sound_effect: SoundEffect, 
	location: Variant # Vector2 or null
) -> Variant:
	if audio_instance is AudioStreamPlayer2D and location != null:
		audio_instance.position = location
	
	audio_instance.stream = sound_effect.sound_effect
	audio_instance.volume_db = sound_effect.volume
	audio_instance.pitch_scale = sound_effect.pitch_scale
	audio_instance.pitch_scale += randf_range(-sound_effect.pitch_randomness, sound_effect.pitch_randomness)
	audio_instance.finished.connect(sound_effect.on_audio_finished)
	audio_instance.finished.connect(audio_instance.queue_free)
	
	return audio_instance

## Creates a sound effect at a specific location if the limit has not been reached. Pass [param location] for the global position of the audio effect, and [param type] for the SoundEffect to be queued.
func create_2d_audio_at_location(location: Vector2, type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	if sound_effect_dict.has(type):
		var sound_effect: SoundEffect = sound_effect_dict[type]
		if not sound_effect.has_open_limit(): return
		
		sound_effect.change_audio_count(1)
		var new_2D_audio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
		add_child(new_2D_audio)
		new_2D_audio = _define_audio_instance(new_2D_audio, sound_effect, location)
		new_2D_audio.play()
	else:
		push_error("Audio Manager failed to find setting for type ", type)


## Creates a sound effect if the limit has not been reached. Pass [param type] for the SoundEffect to be queued.
func create_audio(type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	if sound_effect_dict.has(type):
		var sound_effect: SoundEffect = sound_effect_dict[type]
		if not sound_effect.has_open_limit(): return
		
		sound_effect.change_audio_count(1)
		var new_audio: AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(new_audio)
		new_audio = _define_audio_instance(new_audio, sound_effect, null)
		new_audio.play()
	else:
		push_error("Audio Manager failed to find setting for type ", type)
