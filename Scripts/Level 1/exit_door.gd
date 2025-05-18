extends InteractiveDoor

signal level_end

func _ready() -> void:
	init(SceneManager.GameScenes.LEVEL_1_COMPLETED, $"../key")

@rpc("any_peer", "call_remote")
func finish_level():
	emit_signal("level_end")
	var is_host_or_singleplayer := (MultiplayerManager.IS_MULTIPLAYER and MultiplayerManager.IS_HOST) or not MultiplayerManager.IS_MULTIPLAYER;
	if is_host_or_singleplayer:
		AudioManagerInstance.create_audio(SoundEffect.SOUND_EFFECT_TYPE.ON_DOOR_OPEN)
	
	SceneManager.change_to_scene(self.target_scene)
	
func _process(_delta):
	if not InputManager.is_action_just_pressed("Interact"): return
	for player in players_inside:
		var allow_finish = player.is_active_player() && (key == null || key.get_key_status())
		if not allow_finish: continue
		if MultiplayerManager.IS_MULTIPLAYER:
			finish_level.rpc_id(MultiplayerManager.CLIENT_ID)
		
		finish_level()
