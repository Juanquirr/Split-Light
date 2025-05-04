extends GutTest

class TestBaseInventoryItem:
	extends GutTest
	
	var item: BaseInventoryItem
	var parent_node: Node2D
	var icon: Sprite2D

	func before_each():
		# Setup test environment
		parent_node = Node2D.new()
		icon = Sprite2D.new()
		item = BaseInventoryItem.new(icon, parent_node)
		
		# Ensure the parent is added to the scene tree for proper lifecycle
		add_child(parent_node)

	func after_each():
		# Cleanup
		parent_node.queue_free()
		item.free()
		item = null
		icon.queue_free()

	func test_init():
		# Verify initialization
		assert_not_null(item.parent_node, "Parent node should be set")
		assert_not_null(item.raycast, "Raycast should be created")
		assert_eq(item.raycast.target_position, Vector2(0, 300), "Raycast target position should be set")
		assert_false(item.raycast.enabled, "Raycast should be disabled initially")
		assert_false(item.raycast.visible, "Raycast should be invisible")
		assert_eq(item.raycast.collision_mask, 1, "Collision mask should be 1")
		assert_true(parent_node.has_node(item.raycast.get_path()), "Raycast should be child of parent node")

	func test_take():
		# Test take functionality
		parent_node.visible = true
		item.take()
		assert_false(parent_node.visible, "Parent node should be invisible after take")

	func test_drop():
		# Test drop functionality
		var start_pos = Vector2(100, 100)
		parent_node.visible = false
		item.drop(start_pos)
		assert_true(parent_node.visible, "Parent node should be visible after drop")
		assert_eq(parent_node.position, start_pos, "Parent node position should match start position")
		assert_eq(item.velocity, Vector2.ZERO, "Velocity should be reset to zero")
		assert_true(item.raycast.enabled, "Raycast should be enabled after drop")

	func test_process_no_collision():
		# Test _process when raycast is enabled but not colliding
		item.drop(Vector2(0, 0))
		var initial_pos = parent_node.position
		var delta = 0.016 # Simulate 60 FPS
		# Simulate one frame
		item._process(delta)
		
		# Verify velocity and position changes due to gravity
		var expected_velocity_y = item.GRAVITY * delta
		assert_eq(item.velocity.y, expected_velocity_y, "Velocity should increase by gravity")
		assert_almost_eq(parent_node.position.y, initial_pos.y + item.velocity.y * delta, 0.001, "Position should update based on velocity")
