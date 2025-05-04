extends Control

@onready var action_list: VBoxContainer = $Scroll/ActionList
@onready var scroll_container: ScrollContainer = $Scroll

var awaiting_action: StringName = &""
var awaiting_button: Button = null

func _ready() -> void:
	_build_action_list()

func _build_action_list() -> void:
	# Limpiar lista anterior
	for child in action_list.get_children():
		child.queue_free()

	var actions := InputMap.get_actions()
	for action in actions:
		if action.begins_with("ui"):
			continue  # Ignorar acciones del sistema (ui_up, ui_accept, etc.)

		var hbox := HBoxContainer.new()

		# Etiqueta con el nombre de la acción
		var label := Label.new()
		label.text = str(action)
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.add_child(label)

		# Mostrar la primera tecla/botón asignado
		var current_events := InputMap.action_get_events(action)
		var current_input := ""
		if current_events.size() > 0:
			current_input = current_events[0].as_text()

		var current_input_label := Label.new()
		current_input_label.text = current_input
		current_input_label.name = "CurrentInput"
		current_input_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.add_child(current_input_label)

		# Botón para cambiar la asignación
		var button := Button.new()
		button.text = "Cambiar"
		button.name = str(action)
		button.pressed.connect(_on_change_button_pressed.bind(button))
		hbox.add_child(button)

		action_list.add_child(hbox)

func _on_change_button_pressed(button: Button) -> void:
	awaiting_action = button.name
	awaiting_button = button
	button.text = "Esperando..."
	print("Esperando nueva entrada para:", awaiting_action)

func _input(event: InputEvent) -> void:
	if awaiting_action != &"" and event.is_pressed():
		if event is InputEventKey or event is InputEventMouseButton or event is InputEventJoypadButton:
			InputMap.action_erase_events(awaiting_action)
			InputMap.action_add_event(awaiting_action, event)

			print("Asignado", event.as_text(), "a", awaiting_action)

			_build_action_list()
			awaiting_action = &""
			awaiting_button = null
