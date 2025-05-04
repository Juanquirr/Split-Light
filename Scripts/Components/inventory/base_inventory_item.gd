extends InventoryItemInterface

class_name BaseInventoryItem

var velocity: Vector2 = Vector2(0, 0) 
@export var GRAVITY: float = 1000  
var raycast: RayCast2D  
var parent_node: Node2D

func _init(icon: Sprite2D, init_parent_node: Node2D) -> void:
	super._init(icon) 
	
	self.parent_node = init_parent_node
	self.raycast = RayCast2D.new() as RayCast2D
	self.raycast.target_position = Vector2(0, 300)  
	self.raycast.enabled = false
	self.raycast.visible = false
	self.raycast.collision_mask = 1 
	self.parent_node.add_child(raycast)

func take():
	self.parent_node.visible = false

func drop(start_position: Vector2):
	self.parent_node.visible = true
	self.parent_node.position = start_position
	self.velocity = Vector2.ZERO  
	self.raycast.enabled = true
		
func _process(delta: float) -> void:
		if not self.raycast.enabled:
			return
			
		if not self.raycast.is_colliding() and self.raycast.enabled:
			self.velocity.y += GRAVITY * delta
			self.parent_node.position += self.velocity * delta
		else:
			var collision_point = self.raycast.get_collision_point()
			self.parent_node.global_position.y = collision_point.y
			self.velocity = Vector2.ZERO
			self.raycast.enabled = false
