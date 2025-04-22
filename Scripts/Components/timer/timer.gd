extends Label

class_name LevelTimer
const TIME = 0

signal time_out
var timer_time: float = TIME
var running = true

func set_timer(time: int):
	timer_time = time
	update_timer_label()

func _ready():
	update_timer_label()
	
func _process(delta: float):
	add_theme_color_override("font_color", Color(1, 1, 1))
	add_theme_color_override("font_outline_color", Color.BLACK)
	add_theme_constant_override("outline_size", 4)

	if running and timer_time > 0:
		timer_time -= delta
		if timer_time < 0:
			timer_time = 0
			running = false
			emit_signal("time_out")
		update_timer_label()
	else:
		SceneManager.change_to_scene(SceneManager.SCENES.GAME_OVER)

func reset_timer():
	timer_time = TIME
	update_timer_label()

func start_timer():
	running = true

func update_timer_label():
	var minutes = int(timer_time / 60)
	var seconds = int(timer_time) % 60
	var milliseconds = int((timer_time - int(timer_time)) * 100)
	text = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

	if timer_time < 60:
		add_theme_color_override("font_color", Color(1, 0, 0))
	#elif timer_time <= 5:
		# add_theme_color_override("font_color", Color(randf(), randf(), randf()))
