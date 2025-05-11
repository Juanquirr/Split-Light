extends InteractiveDoor

signal level_end

func _ready() -> void:
	init(SceneManager.GameScenes.LEVEL_1_COMPLETED, $"../key")

@rpc("any_peer", "call_remote")
func finish_level():
	emit_signal("level_end")
	SceneManager.change_to_scene(self.target_scene)
	
func _process(_delta):
	if not InputManager.is_action_just_pressed("Interact"): return
	for player in players_inside:
		var allow_finish = player.is_active_player() && (key == null || key.get_key_status())
		if not allow_finish: continue
		if MultiplayerManager.IS_MULTIPLAYER:
			finish_level.rpc_id(MultiplayerManager.CLIENT_ID)
		
		finish_level()
