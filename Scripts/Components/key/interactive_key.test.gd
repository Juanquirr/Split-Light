extends GutTest

class MockInventoryItem extends BaseInventoryItem:
	func _process(_delta: float):
		return

class TestInteractiveKey:
	extends GutTest
	
	var parent_node: Node2D
	var icon: Sprite2D
	var key: InteractiveKey
	var mock_inventory_item: BaseInventoryItem

	func before_each():
		# Create a mock inventory item
		parent_node = Node2D.new()
		icon = Sprite2D.new()
		mock_inventory_item = MockInventoryItem.new(icon, parent_node)
		
		# Initialize the InteractiveKey
		key = InteractiveKey.new()
		key.init(true, true, false, mock_inventory_item)
		
		add_child(parent_node)
		
	func after_each():
		key.queue_free()
		mock_inventory_item = null

	func test_initialization():
		assert_eq(key.level_visibility_enabled, true, "Level visibility should be enabled")
		assert_eq(key.player_visibility_enabled, true, "Player visibility should be enabled")
		assert_eq(key.can_be_taken, true, "Key should be interactable")
		assert_eq(key.is_taken, false, "Key should not be taken initially")
		assert_eq(key.inventory_item, mock_inventory_item, "Inventory item should be set")
		assert_eq(key.inventory_item.GRAVITY, key.KEY_GRAVITY, "Gravity should be set on inventory item")
		assert_true(key.visible, "Key should be visible initially")
		assert_eq(key.collision_layer, 1, "Collision layer should be 1 initially")

	func test_make_visible():
		key.make_invisible()
		key.make_visible()
		assert_true(key.visible, "Key should be visible when level and player visibility are enabled and not taken")
		assert_eq(key.collision_layer, 1, "Collision layer should be 1 when visible")
		
		key.is_taken = true
		key.make_visible()
		assert_false(key.visible, "Key should not be visible when taken")
		
		key.is_taken = false
		key.level_visibility_enabled = false
		key.make_visible()
		assert_false(key.visible, "Key should not be visible when level visibility is disabled")
		
		key.level_visibility_enabled = true
		key.player_visibility_enabled = false
		key.make_visible()
		assert_false(key.visible, "Key should not be visible when player visibility is disabled")

	func test_make_invisible():
		key.make_visible()
		key.make_invisible()
		assert_false(key.visible, "Key should be invisible")
		assert_eq(key.collision_layer, 0, "Collision layer should be 0 when invisible")

	func test_take_permission():
		key.enable_take_permission()
		assert_true(key.can_be_taken, "Take permission should be enabled")
		
		key.disable_take_permission()
		assert_false(key.can_be_taken, "Take permission should be disabled")

	func test_get_key_status():
		key.can_be_taken = true
		key.is_taken = true
		assert_true(key.get_key_status(), "Key status should be true when can_be_taken and is_taken are true")
		
		key.can_be_taken = false
		assert_false(key.get_key_status(), "Key status should be false when can_be_taken is false")
		
		key.can_be_taken = true
		key.is_taken = false
		assert_false(key.get_key_status(), "Key status should be false when is_taken is false")

	func test_get_inventory_item():
		assert_eq(key.get_inventory_item(), mock_inventory_item, "Should return the correct inventory item")

	func test_perspective_manager_enable():
		key.interaction_manager.enable()
		assert_true(key.player_visibility_enabled, "Player visibility should be enabled")
		assert_true(key.visible, "Key should be visible")
		assert_true(key.can_be_taken, "Take permission should be enabled")

	func test_perspective_manager_disable():
		key.interaction_manager.disable()
		assert_false(key.player_visibility_enabled, "Player visibility should be disabled")
		assert_false(key.visible, "Key should be invisible")
		assert_false(key.can_be_taken, "Take permission should be disabled")
