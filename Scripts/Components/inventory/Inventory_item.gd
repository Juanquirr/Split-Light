extends Node2D

# interface
class_name Inventory_item

var inventory_icon = null

func _init(icon) -> void:
	inventory_icon = icon
	
func take():
	assert(false, "The take function must be implemented.")

func drop(_start_position: Vector2):
	assert(false, "The drop function must be implemented.")
