extends Node2D

@onready var rotation_puzzle: RotationPuzzleComponent = $Mechanics/RotationPuzzleRandomSolution/RotationPuzzle
@onready var spaceship_light := $Lights/SpaceshipShadow
@onready var abot_instance := $Characters/Player1

func _ready() -> void:
	BackgroundAudioManagerInstance.play_bg_music(BackgroundAudio.BACKGROUND_AUDIO_TYPE.LEVEL_2_THEME)
	rotation_puzzle.rotation_puzzle_completed.connect(clear_spaceship_light)
	
func clear_spaceship_light():
	spaceship_light.visible = false
	AudioManagerInstance.create_audio(SoundEffect.SOUND_EFFECT_TYPE.ON_TASK_COMPLETE_1)
	abot_instance.MAX_AIR_TIME = 3
