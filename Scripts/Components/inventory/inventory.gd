extends Node2D

var inventory: Array[Inventory_item] = [null, null, null]
var selected_index: int = 0
var takeable_items: Array[Inventory_item]


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("take") && inventory.has(null):
		for item in takeable_items:
			if item not in inventory:
				for i in range(inventory.size()):
					if inventory[i] == null:
						inventory[i] = item 
						item.take() 
						break 
				break
			
	if Input.is_action_just_pressed("drop") && inventory[selected_index] != null:
		inventory[selected_index].drop(get_parent().position)
		inventory[selected_index] = null
	if Input.is_action_just_pressed("inventory_slot1"):
		selected_index = 0
	if Input.is_action_just_pressed("inventory_slot2"):
		selected_index = 1
	if Input.is_action_just_pressed("inventory_slot3"):
		selected_index = 2


func _on_area_entered(body: Node2D) -> void:
	if body.has_method("get_inventory_item"):
		takeable_items.append(body.get_inventory_item())

func _on_area_exited(body: Node2D) -> void:
	if body.has_method("get_inventory_item"):
		takeable_items.erase(body.get_inventory_item())
