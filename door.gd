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
	_actualizar_puerta()

func _on_boton1_released():
	boton1_presionado = false
	_actualizar_puerta()

func _on_boton2_pressed():
	boton2_presionado = true
	_actualizar_puerta()

func _on_boton2_released():
	boton2_presionado = false
	_actualizar_puerta()

func _actualizar_puerta():
	if boton1_presionado or boton2_presionado:  # Si al menos un botón está presionado
		abrir_puerta()
	else:
		cerrar_puerta()

func abrir_puerta():
	print("Puerta abierta")
	puerta_cerrada.region_enabled = false
	puerta_abierta.region_enabled = true
	collision_shape.set_deferred("disabled", true)  # Desactiva la colisión

func cerrar_puerta():
	print("Puerta cerrada")
	puerta_cerrada.region_enabled = true
	puerta_abierta.region_enabled = false
	collision_shape.set_deferred("disabled", false)  # Activa la colisión
