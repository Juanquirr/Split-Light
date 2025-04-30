extends GutTest

class TestPlayerInstance:
	extends GutTest

	var _player_test_instance: PlayerInstance = null
	var _mock_animated_sprite: AnimatedSprite2D = null
	
	####
	## Note:
	## Any test using method 'is_on_floor()'
	## will not work.
	## -> is_on_floor() will always return 'false'
	## ##

	func before_each():
		_player_test_instance = PlayerInstance.new()
		# Mock AnimatedSprite2D
		_mock_animated_sprite = double(AnimatedSprite2D).new()
		_player_test_instance.animated_sprite = _mock_animated_sprite
		# Reset input states
		Input.action_release("move_right")
		Input.action_release("move_left")
		Input.action_release("jump")
		
		# Add to tree to enable physics processing
		add_child_autofree(_player_test_instance)
	
	func after_each():
		_player_test_instance.free()
		_player_test_instance = null
		_mock_animated_sprite.free()
		_mock_animated_sprite = null

	func test_is_active_player_returns_correct_state():
		_player_test_instance.is_active = true
		assert_true(_player_test_instance.is_active_player(), "Should return true when is_active is true")
		_player_test_instance.is_active = false
		assert_false(_player_test_instance.is_active_player(), "Should return false when is_active is false")

	func test_animation_process_emits_warning_when_no_animation():
		# Verify empty animation frames
		_player_test_instance._warned_empty_animation = false
		_player_test_instance.animation_process()
		assert_true(_player_test_instance._warned_empty_animation, "Warning flag should remain set")
		# Verify null animation node instance
		_player_test_instance.animated_sprite = null
		_player_test_instance.animation_process()
		assert_true(_player_test_instance._warned_no_animation_attached, "Should set _warned_no_animation_attached when animated_sprite is null")

	func test_physics_process_applies_gravity_when_not_on_floor():
		_player_test_instance.velocity.y = 0
		var delta: float = 0.016  # ~1/60th second
		_player_test_instance._physics_process(delta)
		var expected_velocity_y = _player_test_instance.GRAVITY * delta  # 900 * 0.016 = 14.4
		assert_almost_eq(_player_test_instance.velocity.y, expected_velocity_y, 0.0001, "Velocity.y should increase by gravity * delta")

	func test_physics_process_moves_right_when_active_and_input_pressed():
		_player_test_instance.is_active = true
		# Simulate pressing move_right
		Input.action_press("move_right")
		var delta: float = 0.016
		_player_test_instance._physics_process(delta)
		# Clean up input state
		Input.action_release("move_right")
		assert_eq(_player_test_instance.velocity.x, _player_test_instance.SPEED, "Velocity.x should be SPEED when moving right")
		assert_eq(_player_test_instance.direction, 1, "Direction should be 1 when moving right")
		assert_false(_player_test_instance.animated_sprite.flip_h, "Sprite should not be flipped when moving right")

	func test_physics_process_moves_left_when_active_and_input_pressed():
		_player_test_instance.is_active = true
		# Simulate pressing move_left
		Input.action_press("move_left")
		var delta: float = 0.016
		_player_test_instance._physics_process(delta)
		# Clean up input state
		Input.action_release("move_left")
		assert_eq(-_player_test_instance.velocity.x, _player_test_instance.SPEED, "Velocity.x should be -1 x SPEED when moving left")
		assert_eq(_player_test_instance.direction, -1, "Direction should be -1 when moving left")
		assert_true(_player_test_instance.animated_sprite.flip_h, "Sprite should be flipped when moving left")
