extends Node

@onready var TimerLabel: Label = $TimerLabel

const TIME = 300.0

signal time_out
var timer_time = TIME
var running = true

func _ready():
	update_timer_label()

func _process(delta):
	if Input.is_action_just_pressed("stop_timer"):
		running = !running

	if Input.is_action_just_pressed("reset_timer"):
		reset_timer()

	if running and timer_time > 0:
		timer_time -= delta
		if timer_time < 0:
			timer_time = 0
			running = false
			emit_signal("time_out")
		update_timer_label()

func reset_timer():
	timer_time = TIME
	update_timer_label()

func stop_timer():
	running = false

func start_timer():
	running = true

func update_timer_label():
	var minutes = int(timer_time / 60)
	var seconds = int(timer_time) % 60
	var milliseconds = int((timer_time - int(timer_time)) * 100)
	$TimerLabel.text = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
