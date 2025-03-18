extends StaticBody2D

@export var required_player: String  # Define qué jugador puede activarlo
signal button_pressed
signal button_released

@onready var area = $Area2D  # Referencia al Area2D dentro del botón

func _ready():
	# Conectar señales de detección de colisión
	area.connect("body_entered", Callable(self, "_on_body_entered"))
	area.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == required_player:  # Solo reacciona si es el jugador correcto
		print("Botón activado por:", body.name)
		emit_signal("button_pressed")

func _on_body_exited(body):
	if body.name == required_player:
		print("Botón liberado por:", body.name)
		emit_signal("button_released")
