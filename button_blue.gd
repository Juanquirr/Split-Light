extends StaticBody2D

@export var required_player: String  # Define qué jugador puede activarlo
signal button_pressed
signal button_released

@onready var area = $Area2D  # Referencia al Area2D dentro del StaticBody2D

func _ready():
	# Conectar señales de detección de colisión
	area.connect("body_entered", Callable(self, "_on_body_entered"))
	area.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	print("Botón activado por:", body.name)
	emit_signal("button_pressed")

func _on_body_exited(body):
	print("Botón liberado por:", body.name)
	emit_signal("button_released")


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
