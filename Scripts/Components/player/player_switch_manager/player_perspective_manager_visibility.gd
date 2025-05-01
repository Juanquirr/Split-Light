extends PlayerPerspectiveManagerInterface

class_name PlayerPerspectiveVisibilityManager
var parent_node: Node

func _init(node: Node):
	self.parent_node = node  

func disable():
	self.parent_node.visible = false

func enable():
	self.parent_node.visible = true
