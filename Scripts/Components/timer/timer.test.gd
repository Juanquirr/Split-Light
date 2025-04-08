extends GutTest

class TestLevelTimer:
	extends GutTest

	var LevelTimer = load('res://Scripts/Components/timer/timer.gd')
	var _level_timer: LevelTimer = null

	func before_each():
		_level_timer = LevelTimer.new()
		_level_timer.running = false
		_level_timer.reset_timer()
	
	func after_each():
		_level_timer.free()
		_level_timer = null
		
	func test_set_timer_changes_time():
		_level_timer.set_timer(5)
		assert_eq(_level_timer.timer_time, 5, "Should be 5 seconds")
		_level_timer.set_timer(10)
		assert_eq(_level_timer.timer_time, 10, "Should be 10 seconds")
		_level_timer.set_timer(26)
		assert_eq(_level_timer.timer_time, 26, "Should be 26 seconds")
		_level_timer.set_timer(141)
		assert_eq(_level_timer.timer_time, 141, "Should be 141 seconds")
		
	func test_starting_label_is_initial_time():
		_level_timer.set_timer(5)
		assert_eq(_level_timer.text, "00:05:00", "Should be 00:05:00")
		_level_timer.set_timer(10)
		assert_eq(_level_timer.text, "00:10:00", "Should be 00:10:00")
		_level_timer.set_timer(300)
		assert_eq(_level_timer.text, "05:00:00", "Should be 05:00:00")
		_level_timer.set_timer(87)
		assert_eq(_level_timer.text, "01:27:00", "Should be 01:27:00")
