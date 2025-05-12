extends InteractiveKey


class BaseInventoryKey extends BaseInventoryItem:
	var key_on_floor = false

	func wait(seconds: float) -> void:
		await self.parent_node.get_tree().create_timer(seconds).timeout

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
		
	func _process(delta: float) -> void:
		super._process(delta)
		# TODO: add logic to check when a collision with
		# floor happens,
		# play key_drop audio

func _ready() -> void:
	var inventory_key: BaseInventoryItem = BaseInventoryKey.new($Sprite2D, self)
	init(false, false, false, inventory_key)
