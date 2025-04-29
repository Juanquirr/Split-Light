extends Inventory_item

class_name Base_inventory_item

var velocity = Vector2(0, 0) 
var gravity = 1000  
var raycast: RayCast2D  
var parent_node

func _init(icon: Sprite2D, parent_node: Node2D) -> void:
	super._init(icon) 
	
	self.parent_node = parent_node
	raycast = RayCast2D.new() as RayCast2D
	raycast.target_position = Vector2(0, 300)  
	raycast.enabled = false  
	raycast.visible = false
	raycast.collision_mask = 1 
	parent_node.add_child(raycast)

func take():
	parent_node.visible = false

func drop(start_position: Vector2):
	parent_node.visible = true
	parent_node.position = start_position
	velocity = Vector2.ZERO  
	raycast.enabled = true
		
func _process(delta: float) -> void:
		if not raycast.enabled:
			return
		if not raycast.is_colliding() and raycast.enabled:
			velocity.y += gravity * delta
			parent_node.position += velocity * delta
		else:
					
			var collision_point = raycast.get_collision_point()
			
			parent_node.global_position.y = collision_point.y

			velocity = Vector2.ZERO
			raycast.enabled = false
			var collider = raycast.get_collider()
			
	
