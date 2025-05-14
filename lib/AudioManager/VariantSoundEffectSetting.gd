extends Resource

class_name VariantSoundEffect 
## Sound effect resource, used to configure unique sound effects for use with the AudioManager. Passed to [method AudioManager.create_2d_audio_at_location()] and [method AudioManager.create_audio()] to play sound effects.

## Stores sound types that contain different sounds to be trigger to add variance.
enum VARIANT_SOUND_EFFECT_TYPE {
	ON_STONE_WALK,
	ON_WOOD_WALK
}

## Maximum number of this SoundEffect to play simultaneously before culled.
@export_range(0, 10) var limit: int = 5
## The unique sound effect in the [enum VARIANT_SOUND_EFFECT_TYPE] to associate with this effect. Each SoundEffect resource should have it's own unique [enum SOUND_EFFECT_TYPE] setting.
@export var type: VARIANT_SOUND_EFFECT_TYPE 
## The [AudioStream] audio resources to play with variants.
@export var sound_variants: Array[AudioStream] 
## The volume of the [member sound_effect].
@export_range(-40, 20) var volume: float = 0 
## The pitch scale of the [member sound_effect].
@export_range(0.0, 4.0,.01) var pitch_scale: float = 1.0 
## The pitch randomness setting of the [member sound_effect].
@export_range(0.0, 1.0,.01) var pitch_randomness: float = 0.0 

## The instances of this [AudioStream] currently playing.
var audio_count: int = 0


## Returns the amount of possible sounds the sound effect has
func variant_amount() -> int:
	return len(sound_variants)


## Takes [param amount] to change the [member audio_count]. 
func change_audio_count(amount: int) -> void:
	audio_count = max(0, audio_count + amount)


## Checkes whether the audio limit is reached. Returns true if the [member audio_count] is less than the [member limit].
func has_open_limit() -> bool:
	return audio_count < limit


## Connected to the [member sound_effect]'s finished signal to decrement the [member audio_count].
func on_audio_finished() -> void:
	change_audio_count(-1)
