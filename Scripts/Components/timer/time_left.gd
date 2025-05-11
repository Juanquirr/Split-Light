extends RichTextLabel

func _ready() -> void:
	if MultiplayerManager.IS_MULTIPLAYER:
		multiplayer.multiplayer_peer = MultiplayerManager.SERVER
		if MultiplayerManager.IS_HOST:
			update_client_time()
	update_label_time()
	SaveLoadManager.on_level_completed("level_1")


func update_client_time():
	rpc_id(MultiplayerManager.CLIENT_ID, "receive_number", GetFinalTime.get_final_time())

@rpc("any_peer", "call_remote")
func receive_number(number: int):
	GetFinalTime.set_final_time(number)
	update_label_time()
	SaveLoadManager.on_level_completed("level_1")

func update_label_time():
	var time_remaining = GetFinalTime.get_final_time()
	var minutes = int(time_remaining / 60)
	var seconds = int(time_remaining) % 60
	var milliseconds = int((time_remaining - int(time_remaining)) * 100)
	text ="Remaining Time: " + "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func _process(_delta: float) -> void:
	pass
