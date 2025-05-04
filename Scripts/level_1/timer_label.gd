extends LevelTimer

func _ready() -> void:
	set_timer(300)
	super._ready()

func set_remaining_time():
	GetFinalTime.set_final_time(timer_time)
