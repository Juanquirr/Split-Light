extends Player_perspective_manager

class_name Player_perspective_manager_visibility
var parent_node  


func _init(node):
	parent_node = node  

func disable():
	parent_node.visible = false

func enable():
	parent_node.visible = true
