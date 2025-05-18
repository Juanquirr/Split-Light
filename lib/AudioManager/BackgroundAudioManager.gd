extends Node2D

## Loads all registered [BackgroundAudio] on ready as a reference.
var background_music_dict := {}

## Stores all possible [SoundEffects] that can be played.
@export var background_music: Array[BackgroundAudio]

var active_instance: AudioStreamPlayer = null
var last_playback_pos := 0.0

func _ready() -> void:
	for bg_audio in background_music:
		background_music_dict[bg_audio.type] = bg_audio

func get_global_audio_modifier() -> float:
	return SaveLoadManager.get_bg_music_audio_level() / 100.0

func update_global_audio_volume():
	if active_instance == null: return
	active_instance.volume_linear = get_global_audio_modifier()

func _define_audio_instance(
	audio_instance: AudioStreamPlayer,
	bg_music: BackgroundAudio, 
) -> AudioStreamPlayer:
	
	audio_instance.stream = bg_music.audio_track
	audio_instance.volume_db = bg_music.volume
	audio_instance.volume_linear = get_global_audio_modifier()
	audio_instance.finished.connect(bg_music.on_audio_finished)
	
	return audio_instance
	
func stop_active_audio():
	if active_instance == null: return
	
	active_instance.stop()
	active_instance.queue_free()
	active_instance = null
	
func pause_active_audio():
	if active_instance == null: return
	self.last_playback_pos = active_instance.get_playback_position()
	self.active_instance.stop()
	
func resume_active_audio():
	if active_instance == null: return
	self.active_instance.play(last_playback_pos)

func play_bg_music(type: BackgroundAudio.BACKGROUND_AUDIO_TYPE):
	if not background_music_dict.has(type):
		push_error("Could not find registered background music type: ", type)
		return
	
	stop_active_audio()
	var audio_instance := AudioStreamPlayer.new()
	add_child(audio_instance)
	var bg_music := background_music[type]
	bg_music.change_audio_count(1)
	audio_instance = self._define_audio_instance(audio_instance, bg_music)

	if bg_music.loop:
		audio_instance.finished.connect(func(): play_bg_music(type))
	else:
		audio_instance.finished.connect(audio_instance.queue_free)
	
	self.active_instance = audio_instance
	self.active_instance.play()
