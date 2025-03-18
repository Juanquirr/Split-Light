extends Player_perspective_manager

class_name Player_perspective_manager_visibility
var parent_node  
var is_active: bool 
var default_collision_layer: int

func _init(node):
	parent_node = node  
	default_collision_layer = parent_node.collision_layer

func disable():
	parent_node.visible = false
	parent_node.collision_layer = 2
 
func enable():
	parent_node.visible = true
	parent_node.collision_layer = default_collision_layer
