extends Area2D

class_name Teleporter
enum EXIT_DIRECTION { LEFT, RIGHT }  

var scene_target_teleporter: Area2D = self
var direction: EXIT_DIRECTION = EXIT_DIRECTION.LEFT 

signal teleported(body)

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))
	
func init(target_teleporter: Area2D, teleporter_direction: EXIT_DIRECTION):
	self.scene_target_teleporter = target_teleporter
	self.direction = teleporter_direction

func _on_body_entered(body: PhysicsBody2D):
	var relative_height = body.global_position.y - self.global_position.y  
	var relative_x = body.global_position.x - self.global_position.x  
	emit_signal("teleported", body)
	scene_target_teleporter.migrate_body(body, relative_x, relative_height)

func migrate_body(body: PhysicsBody2D, relative_x: float, relative_height: float):
	if body and body is Node2D: 
		var offset_x = 0
		if direction == EXIT_DIRECTION.LEFT:
			offset_x -= abs(relative_x) * 2  
		elif direction == EXIT_DIRECTION.RIGHT:
			offset_x += abs(relative_x) * 2 
		var new_x_position = self.global_position.x + offset_x 
		body.global_position = Vector2(new_x_position, self.global_position.y + relative_height)
