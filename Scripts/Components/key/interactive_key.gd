extends Area2D

class_name InteractiveKey

class KeyPerspectiveManager extends PlayerPerspectiveManagerInterface:
	var node: Node2D
	
	func _init(init_node: Node2D):
		self.node = init_node  
	
	func disable():
		self.node.make_invisible()
		self.node.disable_player_visibility()
		self.node.disable_take_permission()
	
	func enable():
		self.node.enable_player_visibility()
		self.node.make_visible()
		self.node.enable_take_permission()

var interaction_manager: KeyPerspectiveManager
var is_taken = false
var can_be_taken = true
var level_visibility_enabled = true
var player_visibility_enabled = true
var inventory_item: BaseInventoryItem
@export var KEY_GRAVITY: float = 1000

func init(
	enable_visibility: bool,
	interactable: bool,
	taken: bool,
	inventory_item_instance: BaseInventoryItem
):
	self.interaction_manager = KeyPerspectiveManager.new(self)
	self.level_visibility_enabled = enable_visibility
	self.can_be_taken = interactable
	self.is_taken = taken
	self.inventory_item = inventory_item_instance
	self.inventory_item.GRAVITY = self.KEY_GRAVITY
	self.make_visible()

func _process(delta: float) -> void:
	inventory_item._process(delta)
	
func enable_level_visibility():
	level_visibility_enabled = true

func disable_level_visibility():
	level_visibility_enabled = false

func enable_player_visibility():
	player_visibility_enabled = true

func disable_player_visibility():
	player_visibility_enabled = false

func make_visible():
	if level_visibility_enabled && player_visibility_enabled && not is_taken :
		self.visible = true
		self.collision_layer = 1

func make_invisible():
	self.visible = false
	self.collision_layer = 0
	
func enable_take_permission():
	can_be_taken = true
	
func disable_take_permission():
	can_be_taken = false

func get_key_status() -> bool:
	return can_be_taken && is_taken

func get_inventory_item() -> BaseInventoryItem:
	return inventory_item
	
