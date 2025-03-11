extends StaticBody2D

@onready var puerta_cerrada = $CloseDoor
@onready var puerta_abierta = $OpenDoor
@onready var collision_shape = $CollisionShape2D

var boton1_presionado = false
var boton2_presionado = false

func _ready():
	# Conectar señales de los botones
	get_node("../ButtonRed").button_pressed.connect(_on_boton1_pressed)
	get_node("../ButtonRed").button_released.connect(_on_boton1_released)
	get_node("../ButtonBlue").button_pressed.connect(_on_boton2_pressed)
	get_node("../ButtonBlue").button_released.connect(_on_boton2_released)

func _on_boton1_pressed():
	boton1_presionado = true
	print("Botón Rojo presionado")
	_actualizar_puerta()

func _on_boton1_released():
	boton1_presionado = false
	print("Botón Rojo liberado")
	_actualizar_puerta()

func _on_boton2_pressed():
	boton2_presionado = true
	print("Botón Azul presionado")
	_actualizar_puerta()

func _on_boton2_released():
	boton2_presionado = false
	print("Botón Azul liberado")
	_actualizar_puerta()

func _actualizar_puerta():
	print("Estado de botones -> Rojo:", boton1_presionado, "| Azul:", boton2_presionado)
	
	if boton1_presionado or boton2_presionado:  # Se abre si al menos un botón está activado
		abrir_puerta()
	else:
		cerrar_puerta()

func abrir_puerta():
	print("Intentando abrir la puerta...")
	puerta_cerrada.visible = false
	puerta_abierta.visible = true
	collision_shape.set_deferred("disabled", true)  # Desactiva la colisión

func cerrar_puerta():
	print("Intentando cerrar la puerta...")
	puerta_cerrada.visible = true
	puerta_abierta.visible = false
	collision_shape.set_deferred("disabled", false)  # Activa la colisión


func _on_button_red_button_pressed() -> void:
	pass # Replace with function body.


func _on_button_red_button_released() -> void:
	pass # Replace with function body.


func _on_button_blue_button_pressed() -> void:
	pass # Replace with function body.


func _on_button_blue_button_released() -> void:
	pass # Replace with function body.
