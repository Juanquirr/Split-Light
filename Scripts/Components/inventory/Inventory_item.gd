extends Node2D

class_name InventoryItemInterface

var inventory_icon: Sprite2D = null

func _init(icon: Sprite2D) -> void:
	self.inventory_icon = icon
	
func take():
	assert(false, "The take function must be implemented.")

func drop(_start_position: Vector2):
	assert(false, "The drop function must be implemented.")
