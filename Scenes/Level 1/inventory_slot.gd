extends Control

class_name InventorySlotLevel1

var is_selected: bool = false

func check_active_player(active_player: PlayerInstance):
	if get_parent().get_parent().get_parent() != active_player:
		self.visible = false
	else:
		await get_tree().process_frame
		self.visible = true

func _process(_delta: float) -> void:
	var viewport = get_viewport()
	var viewport_size = viewport.get_visible_rect().size
	var slot_index = int(name.replace("Slot", "")) - 1
	var offset = Vector2(slot_index * 70, 0)
	position = Vector2(50, viewport_size.y - 100 - size.y) + offset

func _ready() -> void:
	size = Vector2(48, 48)
	await get_tree().process_frame
	var player_switch_manager = get_node("/root/PlaygroundMalbork/Characters/PlayerSwitchManager")
	if player_switch_manager:
		player_switch_manager.connect("player_changed", Callable(self, "check_active_player"))

func _draw() -> void:
	var rect = Rect2(Vector2.ZERO, size)
	var background_color = Color(0.2, 0.2, 0.2, 1.0)
	draw_rect(rect, background_color, true) 
	
	var border_color = Color(1, 1, 1) 
	if is_selected:
		border_color = Color(0, 1, 0) 
	
	var border_width = 2
	draw_rect(rect, border_color, false, border_width) 

func select() -> void:
	is_selected = true
	queue_redraw() 

func deselect() -> void:
	is_selected = false
	queue_redraw()
