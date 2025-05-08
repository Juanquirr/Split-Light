extends Node

var save_path = "user://save_game.dat"

var levels: Dictionary = {}

var game_data: Dictionary = {
	"InputMap": {},
	"levels": {}
}

func _ready() -> void:
	load_game_data()

func store_game_data() -> void:
	var input_map_data := {}

	for action in InputMap.get_actions():
		input_map_data[action] = []
		for event in InputMap.action_get_events(action):
			var event_data = serialize_input_event(event)
			if event_data:
				input_map_data[action].append(event_data)
	game_data["InputMap"] = input_map_data
	game_data["levels"] = levels
	
	var save_file = FileAccess.open(save_path, FileAccess.WRITE)
	if save_file == null:
		print("Error: Could not open the file for writing: ", FileAccess.get_open_error())
		return
	save_file.store_var(game_data, true)
	save_file.close()
	print("Game data and levels stored at: ", save_path)

func load_game_data() -> void:
	if not FileAccess.file_exists(save_path):
		print("Save file not found: ", save_path)
		return
	
	var save_file = FileAccess.open(save_path, FileAccess.READ)
	if save_file == null:
		print("Error: Could not open the file for reading: ", FileAccess.get_open_error())
		return
	
	game_data = save_file.get_var(true)
	save_file.close()
	
	if game_data.has("InputMap"):
		var saved_input_map = game_data["InputMap"]
		for action in saved_input_map.keys():
			if not InputMap.has_action(action):
				InputMap.add_action(action)
			else:
				InputMap.action_erase_events(action)
			
			for event_data in saved_input_map[action]:
				if event_data is Dictionary:
					var event = deserialize_input_event(event_data)
					if event:
						InputMap.action_add_event(action, event)
	
	if game_data.has("levels"):
		levels = game_data["levels"]

func serialize_input_event(event: InputEvent) -> Dictionary:
	if event is InputEventKey:
		return {
			"type": "InputEventKey",
			"keycode": event.keycode,
			"physical_keycode": event.physical_keycode,
			"modifier_alt": event.alt_pressed,
			"modifier_shift": event.shift_pressed,
			"modifier_ctrl": event.ctrl_pressed,
			"modifier_meta": event.meta_pressed
		}
	elif event is InputEventMouseButton:
		return {
			"type": "InputEventMouseButton",
			"button_index": event.button_index,
			"double_click": event.double_click
		}
	return {}

func deserialize_input_event(data: Dictionary) -> InputEvent:
	if not data is Dictionary or not data.has("type"):
		return null
	
	if data["type"] == "InputEventKey":
		var event = InputEventKey.new()
		event.keycode = data.get("keycode", 0)
		event.physical_keycode = data.get("physical_keycode", 0)
		event.alt_pressed = data.get("modifier_alt", false)
		event.shift_pressed = data.get("modifier_shift", false)
		event.ctrl_pressed = data.get("modifier_ctrl", false)
		event.meta_pressed = data.get("modifier_meta", false)
		return event
	elif data["type"] == "InputEventMouseButton":
		var event = InputEventMouseButton.new()
		event.button_index = data.get("button_index", 0)
		event.double_click = data.get("double_click", false)
		return event
	return null
	


func on_level_completed(level_name: String) -> void:
	levels[level_name] = true
	store_game_data()
	
func is_level_completed(level_name: String) -> bool:
	return levels.get(level_name, false) 
