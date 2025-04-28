extends InteractiveKey

class Base_inventory_key extends Base_inventory_item:

	func take():
		super.take()
		parent_node.is_taken = true
		parent_node.make_invisible()
		
	func drop(start_position: Vector2):
		super.drop(start_position)
		parent_node.is_taken = false
		parent_node.make_visible()
		
			

func _ready() -> void:
	init(false,false,false)
	inventory_item = Base_inventory_key.new($"Sprite2D", self)
	
