extends Control

@onready var action_list: VBoxContainer = $Scroll/ActionList
@onready var scroll_container: ScrollContainer = $Scroll
@onready var custom_font: FontFile = preload("res://Assets/Fonts/yoster.ttf")

var awaiting_action: StringName = &""
var awaiting_button: Button = null

func _ready() -> void:
	_build_action_list()

func _build_action_list() -> void:
	for child in action_list.get_children():
		child.queue_free()

	var actions := InputMap.get_actions()
	var label_settings := LabelSettings.new()
	label_settings.font = custom_font
	var button_theme := _create_button_theme()

	for action in actions:
		if action.begins_with("ui"):
			continue

		var hbox := HBoxContainer.new()

		var label := Label.new()
		label.text = str(action)
		label.label_settings = label_settings
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.add_child(label)

		var current_events := InputMap.action_get_events(action)
		var current_input := ""
		if current_events.size() > 0:
			current_input = current_events[0].as_text()

		var current_input_label := Label.new()
		current_input_label.text = current_input.replace("(Physical)", "")
		current_input_label.name = "CurrentInput"
		current_input_label.label_settings = label_settings
		current_input_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.add_child(current_input_label)

		var button := Button.new()
		button.text = "Change"
		button.name = str(action)
		button.theme = button_theme
		button.pressed.connect(_on_change_button_pressed.bind(button))
		hbox.add_child(button)

		action_list.add_child(hbox)

func _on_change_button_pressed(button: Button) -> void:
	awaiting_action = button.name
	awaiting_button = button
	button.text = "Waiting..."

func _input(event: InputEvent) -> void:
	if awaiting_action != &"" and event.is_pressed():
		if event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton:
			InputMap.action_erase_events(awaiting_action)
			InputMap.action_add_event(awaiting_action, event)

			_build_action_list()
			awaiting_action = &""
			awaiting_button = null

func _create_button_theme() -> Theme:
	var button_theme := Theme.new()
	button_theme.set_font("font", "Button", custom_font)
	return button_theme
