extends RichTextLabel

@onready var level_complete_manager: LevelCompleteManager = $".."

var is_new_best_time  := false

func get_level_id():
	return "level_" + str(level_complete_manager.level_number)

func _ready() -> void:
	if MultiplayerManager.IS_MULTIPLAYER:
		multiplayer.multiplayer_peer = MultiplayerManager.SERVER
		if MultiplayerManager.IS_HOST:
			update_client_time()
			
	SaveLoadManager.on_level_completed(get_level_id())
	is_new_best_time = SaveLoadManager.save_level_time(get_level_id(), get_time_string()) 
	update_label_time()

func update_client_time():
	rpc("receive_number", GetFinalTime.get_final_time())

@rpc("authority", "call_remote")
func receive_number(number: float):
	GetFinalTime.set_final_time(number)
	SaveLoadManager.on_level_completed(get_level_id())
	is_new_best_time = SaveLoadManager.save_level_time(get_level_id(), get_time_string()) 
	update_label_time()

func update_label_time():
	var best_time_text = "[color=#FFEB3B]\n New Best Time! [/color]" if is_new_best_time else ""
	text = "Time Taken: " + get_time_string() +  best_time_text

func get_time_string() -> String: 
	var time_remaining = level_complete_manager.total_level_time_in_seconds - GetFinalTime.get_final_time()
	var minutes = int(time_remaining / 60)
	var seconds = int(time_remaining) % 60
	var milliseconds = int((time_remaining - int(time_remaining)) * 100)
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
