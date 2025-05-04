extends InteractiveKey

class BaseInventoryKey extends BaseInventoryItem:
	func take():
		super.take()
		self.parent_node.is_taken = true
		self.parent_node.make_invisible()
		
	func drop(start_position: Vector2):
		super.drop(start_position)
		self.parent_node.is_taken = false
		self.parent_node.make_invisible()
		self.parent_node.make_visible()

func _ready() -> void:
	var inventory_key: BaseInventoryItem = BaseInventoryKey.new($Sprite2D, self)
	init(false, false, false, inventory_key)
