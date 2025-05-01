extends GutTest

class TestCounterLabel:
	extends GutTest
	
	var counter_label: CounterLabel = null

	func before_each():
		self.counter_label = CounterLabel.new()
		self.counter_label.target_number = 5
		self.counter_label.counter = 0
		add_child_autofree(self.counter_label)

	func after_each():
		self.counter_label = null

	func test_initial_state():
		assert_eq(counter_label.get_count(), 0, "Initial counter should be 0")
		assert_eq(counter_label.text, "0", "Initial label text should be '0'")
		assert_eq(counter_label.target_number, 5, "Initial target number should be 5")

	func test_add_count():
		counter_label.add_count()
		assert_eq(counter_label.get_count(), 1, "Counter should increment to 1")
		assert_eq(counter_label.text, "1", "Label text should update to '1'")

	func test_sub_count():
		counter_label.counter = 2
		counter_label.sub_count()
		assert_eq(counter_label.get_count(), 1, "Counter should decrement to 1")
		assert_eq(counter_label.text, "1", "Label text should update to '1'")

	func test_set_counter():
		counter_label.set_counter(10)
		assert_eq(counter_label.get_count(), 10, "Counter should be set to 10")
		assert_eq(counter_label.text, "10", "Label text should update to '10'")

	func test_set_target_number():
		counter_label.set_target_number(8)
		assert_eq(counter_label.target_number, 8, "Target number should be set to 8")

	func test_number_reached_signal():
		watch_signals(counter_label)
		
		counter_label.set_counter(3)
		var emission_count = get_signal_emit_count(counter_label, "number_reached")
		assert_false(emission_count > 0, "Signal should not emit when counter is not at target")
		counter_label.set_counter(5)
		emission_count = get_signal_emit_count(counter_label, "number_reached")
		assert_true(emission_count > 0, "Signal should emit when counter reaches target")

	func test_add_count_reaches_target():
		watch_signals(counter_label)
		
		counter_label.counter = 4
		counter_label.add_count()
		assert_eq(counter_label.get_count(), 5, "Counter should be 5 after increment")
		var emission_count = get_signal_emit_count(counter_label, "number_reached")
		assert_true(emission_count > 0, "Signal should emit when add_count reaches target")

	func test_sub_count_reaches_target():
		watch_signals(counter_label)
		
		counter_label.counter = 6
		counter_label.sub_count()
		assert_eq(counter_label.get_count(), 5, "Counter should be 5 after decrement")
		var emission_count = get_signal_emit_count(counter_label, "number_reached")
		assert_true(emission_count > 0, "Signal should emit when sub_count reaches target")
