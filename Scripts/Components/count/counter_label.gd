extends Label

class_name CounterLabel

var visibility = PlayerPerspectiveVisibilityManager.new(self)

signal number_reached
@export var target_number: int = 0
@export var counter: int = 1

func _ready() -> void:
	self._update_ui()
	
func _update_ui():
	self.text = str(counter)

func add_count():
	self.counter += 1
	self.text = str(counter)
	emit_signal_on_reach()

func sub_count():
	self.counter -= 1
	self._update_ui()
	self.emit_signal_on_reach()

func get_count() -> int:
	return self.counter

func set_counter(value: int):
	self.counter = value
	self._update_ui()
	self.emit_signal_on_reach()

func set_target_number(number: int):
	self.target_number = number

func emit_signal_on_reach():
	if self.target_number == counter:
		emit_signal("number_reached")
