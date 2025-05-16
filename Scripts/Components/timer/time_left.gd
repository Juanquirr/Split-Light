extends RichTextLabel

@onready var level_duration := 300
var is_new_best_time  := false

func _ready() -> void:
	if MultiplayerManager.IS_MULTIPLAYER:
		multiplayer.multiplayer_peer = MultiplayerManager.SERVER
		if MultiplayerManager.IS_HOST:
			update_client_time()
	SaveLoadManager.on_level_completed("level_1")
	is_new_best_time = SaveLoadManager.save_level_time("level_1",get_time_string()) 
	update_label_time()

func update_client_time():
	rpc_id(MultiplayerManager.CLIENT_ID, "receive_number")

@rpc("any_peer", "call_remote")
func receive_number(number: int):
	GetFinalTime.set_final_time(number)
	SaveLoadManager.on_level_completed("level_1")
	is_new_best_time = SaveLoadManager.save_level_time("level_1",get_time_string()) 
	update_label_time()


func update_label_time():
	var best_time_text = "[color=#FFEB3B]\n New Best Time! [/color]" if is_new_best_time else ""
	print(is_new_best_time)
	print(best_time_text)
	text ="Time Taken: " + get_time_string() +  best_time_text

func get_time_string() -> String: 
	var time_remaining = level_duration - GetFinalTime.get_final_time()
	var minutes = int(time_remaining / 60)
	var seconds = int(time_remaining) % 60
	var milliseconds = int((time_remaining - int(time_remaining)) * 100)
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]


func _process(_delta: float) -> void:
	pass
