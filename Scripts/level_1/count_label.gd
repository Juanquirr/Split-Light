extends Label

var visibility = Player_perspective_manager_visibility.new(self)

signal count_changed(new_count)

@export var count = 0

func add_count():
	count = count + 1
	self.text = str(count)
	emit_signal("count_changed", count)

func sub_count():
	count = count -1
	self.text = str(count)
	emit_signal("count_changed", count)

func get_count():
	return count

func set_count(value: int):
	count = value
	self.text = str(count)
	
