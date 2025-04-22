extends LevelTimer

@onready var exit_door: Area2D = $"../ExitDoor"

func _ready() -> void:
	set_timer(300)
	super._ready()
	if (exit_door != null):
		exit_door.connect("level_end", Callable(self, "set_remaining_time"))

func _process(delta: float):
	super._process(delta)

func set_remaining_time():
	GetFinalTime.set_final_time(timer_time)
