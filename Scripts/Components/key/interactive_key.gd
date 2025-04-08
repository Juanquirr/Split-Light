extends Area2D

class_name InteractiveKey

class Key_interaction_manager extends Player_perspective_manager:
	var node  
	func _init(node):
		self.node = node  
	func disable():
		self.node.make_invisible()
		self.node.disable_player_visibility()
		self.node.disable_take_permission()
	func enable():
		self.node.enable_player_visibility()
		self.node.make_visible()
		self.node.enable_take_permission()

var interaction_manager = Key_interaction_manager.new(self)
var is_taken = false
var can_be_taken = true
var level_visibility_enabled = true
var player_visibility_enabled = true

func init(level_visibility_enabled,can_be_taken,taken):
	self.level_visibility_enabled = level_visibility_enabled
	self.can_be_taken = can_be_taken
	self.is_taken = taken
	self.make_visible()
	
func _ready():
	self.make_invisible()

func _on_body_entered(body):
	if body.name.begins_with("Player") and body.is_active_player() and self.visible and can_be_taken:
		is_taken = true
		self.visible = false

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

func make_invisible():
	self.visible = false
	
func enable_take_permission():
	can_be_taken = true
	
func disable_take_permission():
	can_be_taken = false

func get_key_status():
	return can_be_taken && is_taken
