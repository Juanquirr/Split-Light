extends Button

@onready var InputSettings = $"../../InputSettings"
@onready var PauseMenu = $"../.."
@onready var PauseMenuColor = $"../../ColorRect"
@onready var Pause = $"../../VBoxContainer"
@onready var Black = $"../../Black"

func _on_pressed() -> void:
	PauseMenuColor.hide()
	Pause.hide()
	Black.show()
	InputSettings.show()

func _on_cancel_quit_pressed() -> void:
	InputSettings.hide()
	Black.hide()
	PauseMenuColor.show()
	Pause.show()
