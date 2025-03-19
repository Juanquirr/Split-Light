extends Node2D

var active_player  # Referencia al jugador activo

@onready var player1 = $Player1
@onready var player2 = $Player2

@onready var camera1 = $Player1/Camera2D
@onready var camera2 = $Player2/Camera2D

@onready var label = $Count

func _ready():
	await get_tree().process_frame  # Esperamos a que todo cargue correctamente
	active_player = player1  # Comienza con Player1 activo
	_update_active_camera()
	player1.count_changed.connect(_on_count_changed)
	_on_count_changed(player1.count)

func _process(delta):
	if Input.is_action_just_pressed("switch_player"):
		if active_player == player1:
			active_player = player2
		else:
			active_player = player1
		_update_active_camera()

func _update_active_camera():
	if camera1 and camera2:  # Verificamos que las cámaras existan antes de modificarlas
		camera1.enabled = (active_player == player1)
		camera2.enabled = (active_player == player2)

func _on_count_changed(new_count):
	label.text = str(new_count)
