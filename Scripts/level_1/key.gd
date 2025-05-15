extends InteractiveKey


class BaseInventoryKey extends BaseInventoryItem:
	func play_drop_sound():
		AudioManagerInstance.create_audio(
			SoundEffect.SOUND_EFFECT_TYPE.ON_KEY_DROP
		)
	
	func _init(icon: Sprite2D, init_parent_node: Node2D) -> void:
		super._init(icon, init_parent_node)
		self.touched_floor.connect(play_drop_sound)
	
	func take():
		super.take()
		self.parent_node.is_taken = true
		AudioManagerInstance.create_audio(
			SoundEffect.SOUND_EFFECT_TYPE.ON_KEY_GRAB
		)
		self.parent_node.make_invisible()
		
	func drop(start_position: Vector2):
		super.drop(start_position)
		self.parent_node.is_taken = false
		self.parent_node.make_invisible()
		self.parent_node.make_visible()

func _ready() -> void:
	var inventory_key: BaseInventoryItem = BaseInventoryKey.new($Sprite2D, self)
	init(false, false, false, inventory_key)
