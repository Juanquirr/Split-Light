extends Resource

class_name BackgroundAudio 

enum BACKGROUND_AUDIO_TYPE {
	MENU_THEME,
	LEVEL_1_THEME,
	LEVEL_2_THEME,
}

@export var loop := true
@export var type: BACKGROUND_AUDIO_TYPE ## The unique sound effect in the [enum SOUND_EFFECT_TYPE] to associate with this effect. Each SoundEffect resource should have it's own unique [enum SOUND_EFFECT_TYPE] setting.
@export var audio_track: AudioStream ## The [AudioStream] audio resource to play.
@export_range(-40, 20) var volume: float = -3.5 ## The volume of the [member sound_effect].

var limit := 1
var audio_count := 0

## Takes [param amount] to change the [member audio_count]. 
func change_audio_count(amount: int) -> void:
	audio_count = max(0, audio_count + amount)


## Checkes whether the audio limit is reached. Returns true if the [member audio_count] is less than the [member limit].
func has_open_limit() -> bool:
	return audio_count < limit


## Connected to the [member sound_effect]'s finished signal to decrement the [member audio_count].
func on_audio_finished() -> void:
	change_audio_count(-1)
