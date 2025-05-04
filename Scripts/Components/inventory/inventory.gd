extends Node2D

var inventory: Array[InventoryItemInterface] = [null, null, null]
var selected_index: int = 0
var takeable_items: Array[InventoryItemInterface]
var item_sprites: Array[Sprite2D] = [null, null, null] 
var slots_offset = [Vector2(-460, +335),Vector2(-390, +335), Vector2(-323, +335)]

func check_active_player(active_player):
	if get_parent() != active_player:
		for item in item_sprites:
			if item != null:
				item.visible = false
	else:
		for item in item_sprites:
			if item != null:
				item.visible = true

func _ready() -> void:
	$Slot1.select()
	var player_switch_manager = get_node_or_null("../../PlayerSwitchManager")
	if player_switch_manager:
		player_switch_manager.connect("player_changed", Callable(self, "check_active_player"))

func get_inventory_items():
	return takeable_items

func update_item_sprites_position():
	for index in range(3):
		if item_sprites[index] == null: continue
		item_sprites[index].global_position = $"../Camera2D".get_screen_center_position() + slots_offset[index]  

func _process(_delta: float) -> void:	
	update_item_sprites_position()
	
	var parent = get_parent()
	if parent and parent.has_method("is_active_player") and not parent.is_active_player():
		return
	
	if Input.is_action_just_pressed("take") && inventory.has(null):
		for item in takeable_items:
			if item not in inventory:
				for i in range(inventory.size()):
					if inventory[i] == null:
						inventory[i] = item
						item.take()
						
						if item.inventory_icon != null:
							var sprite = item.inventory_icon.duplicate()
							
							sprite.scale = Vector2(1, 1) 
							
							var desired_size = Vector2(48, 48)
							var texture_size = sprite.texture.get_size()
							sprite.scale = desired_size / texture_size
							add_child(sprite)
							item_sprites[i] = sprite
							update_item_sprites_position()
						break
				break
	
	if Input.is_action_just_pressed("drop") && inventory[selected_index] != null:
		inventory[selected_index].drop(get_parent().position)
		
		if item_sprites[selected_index] != null:
			item_sprites[selected_index].queue_free()
			item_sprites[selected_index] = null
		inventory[selected_index] = null
	
	if Input.is_action_just_pressed("inventory_slot1"):
		selected_index = 0
		$Slot1.select()
		$Slot2.deselect()
		$Slot3.deselect()
	if Input.is_action_just_pressed("inventory_slot2"):
		selected_index = 1
		$Slot1.deselect()
		$Slot2.select()
		$Slot3.deselect()
	if Input.is_action_just_pressed("inventory_slot3"):
		selected_index = 2
		$Slot1.deselect()
		$Slot2.deselect()
		$Slot3.select()

func _on_area_entered(body: Node2D) -> void:
	if body.has_method("get_inventory_item"):
		takeable_items.append(body.get_inventory_item())

func _on_area_exited(body: Node2D) -> void:
	if body.has_method("get_inventory_item"):
		takeable_items.erase(body.get_inventory_item())
