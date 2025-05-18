extends Button

@onready var SettingsScreen = $"../../SettingsScreen"
@onready var PauseMenu = $"../.."
@onready var PauseMenuColor = $"../../ColorRect"
@onready var Pause = $"../../VBoxContainer"
@onready var Black = $"../../Black"

func _on_pressed() -> void:
	PauseMenuColor.hide()
	Pause.hide()
	Black.show()
	SettingsScreen.show()

func _on_cancel_quit_pressed() -> void:
	SettingsScreen.hide()
	Black.hide()
	PauseMenuColor.show()
	Pause.show()
