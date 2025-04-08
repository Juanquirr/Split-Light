extends Area2D

class_name Teleporter
enum exit_direction { LEFT, RIGHT }  

var connected_teleporter = self
var direction = exit_direction.LEFT 

signal teleported(body)


func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func init(connected_teleporter, exit_direction):
	self.connected_teleporter = connected_teleporter
	self.direction = exit_direction

func _on_body_entered(body):
	var relative_height = body.global_position.y - self.global_position.y  
	var relative_x = body.global_position.x - self.global_position.x  
	emit_signal("teleported", body)
	connected_teleporter.migrate_item(body, relative_x, relative_height)

func migrate_item(item, relative_x, relative_height):
	if item and item is Node2D: 
		var offset_x = 0
		if direction == exit_direction.LEFT:
			offset_x -= abs(relative_x) * 2  
		elif direction == exit_direction.RIGHT:
			offset_x += abs(relative_x)  * 2 
		var new_x_position = self.global_position.x + offset_x 
		item.global_position = Vector2(new_x_position, self.global_position.y + relative_height)
	
