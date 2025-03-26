extends Area2D

var is_player_inside_area = false
var player_inside = null
var is_book_opened = false

func _ready():
	# Conexiones de señales en Godot 4
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	# Inicializamos visibilidad
	$BlackPoem.visible = false
	$RedPoem.visible = false
	$MessageLabel.visible = false

func _on_body_entered(body):
	if body.name in ["Player1", "Player2"]:
		is_player_inside_area = true
		player_inside = body
		$MessageLabel.visible = true
		update_poem_visibility(true)

func _on_body_exited(body):
	if body.name in ["Player1", "Player2"]:
		is_player_inside_area = false
		$MessageLabel.visible = false
		update_poem_visibility(false)
		if is_book_opened and player_inside != null:
			is_book_opened = false
			player_inside.get_node("Camera2D").make_current()
		player_inside = null

func _process(delta):
	if is_player_inside_area and player_inside != null:
		# Seleccionamos la acción específica según el jugador dentro
		var interact_action = "Interact_P1" if player_inside.name == "Player1" else "Interact_P2"
		# Solo respondemos si la acción específica se activa
		if Input.is_action_just_pressed(interact_action):
			is_book_opened = !is_book_opened
			update_poem_visibility(is_book_opened)
			if is_book_opened:
				$Camera2D.make_current()
			else:
				player_inside.get_node("Camera2D").make_current()

func update_poem_visibility(show):
	if player_inside != null:
		$BlackPoem.visible = show and player_inside.name == "Player1"
		$RedPoem.visible = show and player_inside.name == "Player2"
