extends Sprite2D
func _ready():
	connect("body_entered", $Area2D, "_on_body_entered")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Jugador se acercó al objeto")
