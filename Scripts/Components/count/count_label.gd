extends Label


class_name Counter
var visibility = Player_perspective_manager_visibility.new(self)

signal number_reached()
@onready var reach_number = null
@export var count = 0
signal teleported(body)

func add_count():
	count = count + 1
	self.text = str(count)
	emit_signal_on_reach()
	

func sub_count():
	count = count -1
	self.text = str(count)
	emit_signal_on_reach()

func get_count():
	return count

func set_count(value: int):
	count = value
	self.text = str(count)
	emit_signal_on_reach()

func set_reach_number(number):
	reach_number = number
	
func emit_signal_on_reach():
	if reach_number != null and reach_number == count:
		emit_signal("number_reached")
		
