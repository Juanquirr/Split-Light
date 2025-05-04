extends TextureButton

@onready var ConfirmQuitScreen = $"../../ConfirmQuitScreen"

func _ready():
	ConfirmQuitScreen.hide()

func _on_quit_button_pressed() -> void:
	ConfirmQuitScreen.show()

func _on_cancel_quit_pressed() -> void:
	ConfirmQuitScreen.hide()

func _on_confirm_quit_pressed() -> void:
	get_tree().quit(0)
