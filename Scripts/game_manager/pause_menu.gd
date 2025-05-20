extends Control

@onready var confirm_quit_screen: Control = $ConfirmQuitScreen
@onready var confirm_restart_screen: Control = $ConfirmRestartScreen
@onready var input_settings_screen: Control = $SettingsScreen
@onready var main_pause_screen: VBoxContainer = $VBoxContainer
@onready var main_pause_bg: ColorRect = $ColorRect
@onready var pause_black_bg: ColorRect = $Black

@export var restart_level: SceneManager.GameScenes

func _reset_state():
	self.confirm_quit_screen.visible = false
	self.confirm_restart_screen.visible = false
	self.input_settings_screen.visible = false
	self.pause_black_bg.visible = false
	self.main_pause_screen.visible = true
	self.main_pause_bg.visible = true
	BackgroundAudioManagerInstance.resume_active_audio()

func _input(event):
	if event.is_action_pressed("pause"):
		if not visible:
			show_pause_menu()
		else:
			unpause()

func show_pause_menu():
	pause()

	var camera = get_viewport().get_camera_2d()
	if camera:
		var screen_center = camera.get_screen_center_position()
		
		if get_tree().current_scene.name == "PlaygroundMalbork":
			position = screen_center - Vector2(1572, 388)
		else:
			position = screen_center

func pause():
	BackgroundAudioManagerInstance.pause_active_audio()
	visible = true
	if not MultiplayerManager.IS_MULTIPLAYER:
		get_tree().paused = true

func unpause():
	visible = false
	self._reset_state()
	
	if not MultiplayerManager.IS_MULTIPLAYER:
		get_tree().paused = false
