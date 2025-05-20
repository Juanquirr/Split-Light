extends LevelTimer

@export var LEVEL_TIME := 300
@export var GAME_OVER_SCENE: SceneManager.GameScenes

func _ready() -> void:
	set_timer(LEVEL_TIME)
	set_game_over_scene(GAME_OVER_SCENE)
	super._ready()

func set_remaining_time():
	GetFinalTime.set_final_time(timer_time)
