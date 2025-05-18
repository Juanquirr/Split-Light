extends Control

@onready var root_screen: Control = $".."
@onready var sound_screen: Control = $"../SoundScreen"
@onready var input_screen: Control = $"../InputSettings"

func _pause_menu_show():
	if root_screen.main_pause_menu == null or root_screen.main_pause_menu_box == null or root_screen.pause_menu_bg == null:
		return
		
	root_screen.pause_menu_bg.visible = false
	root_screen.main_pause_menu_box.visible = true
	root_screen.main_pause_menu.visible = true

func hide_settings_screen():
	root_screen.visible = false
	self._on_sound_tab_clicked()
	self._pause_menu_show()

func _ready() -> void:
	sound_screen.visible = true
	input_screen.visible = false

func _on_sound_tab_clicked():
	input_screen.visible = false
	sound_screen.visible = true
	
func _on_input_tab_clicked():
	sound_screen.visible = false
	input_screen.visible = true
	
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		hide_settings_screen()
