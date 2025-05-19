extends Label

class_name LevelTimer
const TIME = 0

signal time_out

var game_over_scene: SceneManager.GameScenes
var timer_time: float = TIME
var running = true

func set_timer(time):
	timer_time = time
	update_timer_label()
	
func set_game_over_scene(scene: SceneManager.GameScenes):
	self.game_over_scene = scene

func _ready():
	add_theme_color_override("font_color", Color(1, 1, 1))
	add_theme_color_override("font_outline_color", Color.BLACK)
	add_theme_constant_override("outline_size", 4)
	
	update_timer_label()
	
func _process(delta: float):
	if running and timer_time > 0:
		timer_time -= delta
		if timer_time < 0:
			timer_time = 0
			running = false
			emit_signal("time_out")
		update_timer_label()
	else:
		SceneManager.change_to_scene(game_over_scene)

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
	
