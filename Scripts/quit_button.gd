extends TextureButton

@onready var ConfirmQuitScreen = $"../ConfirmQuitScreen"

func _ready():
	ConfirmQuitScreen.hide()

func _on_pressed() -> void:
	ConfirmQuitScreen.show()

func _on_quit_cancel_button_pressed():
	ConfirmQuitScreen.hide()
	
func _on_quit_confirm_button_pressed():
	get_tree().quit()
