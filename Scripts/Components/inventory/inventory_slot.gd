extends Control

class_name InventorySlot

var is_selected: bool = false

func check_active_player(active_player: PlayerInstance):
	if get_parent().get_parent() != active_player:
		self.visible = false
	else:
		await get_tree().process_frame
		self.visible = true

func _process(_delta: float) -> void:
	global_position.y = (get_parent().get_node("../Camera2D").get_screen_center_position().y + 305)
	
func _ready() -> void:
	await get_tree().process_frame
	var player_switch_manager = get_node_or_null("../../../PlayerSwitchManager")
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
