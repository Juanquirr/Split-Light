extends Control

var inventory: Array = [null, null, null]
var selected_index: int = 0
var takeable_items: Array = []
var item_sprites: Array = [null, null, null]
var slots_offset = [Vector2(0, 0), Vector2(70, 0), Vector2(140, 0)]
var active_player: Node = null

var player_inventories := {
	"Player1": [null, null, null],
	"Player2": [null, null, null]
}

var player_item_sprites := {
	"Player1": [null, null, null],
	"Player2": [null, null, null]
}

func set_active_player(player: Node) -> void:
	active_player = player
	inventory = player_inventories[player.name]
	item_sprites = player_item_sprites[player.name]
	check_active_player(player)
	update_item_sprites_position()

func check_active_player(active_player: Node) -> void:
	if active_player != self.active_player:
		for item in item_sprites:
			if item != null:
				item.visible = false
	else:
		for item in item_sprites:
			if item != null:
				item.visible = true

func _ready() -> void:
	$Slot1.select()
	var player_switch_manager = get_node("/root/PlaygroundMalbork/Characters/PlayerSwitchManager")
	if player_switch_manager:
		player_switch_manager.connect("player_changed", Callable(self, "set_active_player"))
	set_active_player(get_node("/root/PlaygroundMalbork/Characters/Player1"))

func get_inventory_items() -> Array:
	return takeable_items

func update_item_sprites_position() -> void:
	var viewport = get_viewport()
	var viewport_size = viewport.get_visible_rect().size
	var bottom_left = Vector2(50, viewport_size.y - 100)

	for index in range(3):
		if item_sprites[index] == null:
			continue
		item_sprites[index].global_position = bottom_left + slots_offset[index]

func _process(_delta: float) -> void:
	update_item_sprites_position()

	if active_player and active_player.has_method("is_active_player") and not active_player.is_active_player():
		return

	if Input.is_action_just_pressed("take") and inventory.has(null):
		if active_player:
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
								if texture_size.x > 0 and texture_size.y > 0:
									sprite.scale = desired_size / texture_size
								else:
									sprite.scale = Vector2(1, 1)
								add_child(sprite)
								item_sprites[i] = sprite
								player_item_sprites[active_player.name][i] = sprite
								update_item_sprites_position()
							break
					break

	if Input.is_action_just_pressed("drop") and inventory[selected_index] != null:
		inventory[selected_index].drop(active_player.position)
		if item_sprites[selected_index] != null:
			item_sprites[selected_index].queue_free()
			item_sprites[selected_index] = null
			player_item_sprites[active_player.name][selected_index] = null
		inventory[selected_index] = null
		player_inventories[active_player.name][selected_index] = null

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

func _on_inventory_area_area_entered(area: Area2D) -> void:
	if area.has_method("get_inventory_item"):
		takeable_items.append(area.get_inventory_item())

func _on_inventory_area_area_exited(area: Area2D) -> void:
	if area.has_method("get_inventory_item"):
		takeable_items.erase(area.get_inventory_item())
