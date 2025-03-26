extends Area2D

var is_player_inside_area = false
var player_inside = null
var is_book_opened = false

var visibility_red_poem = null
var visibility_black_poem = null


func _ready():
	visibility_red_poem = Player_perspective_manager_visibility.new($RedPoem)
	visibility_black_poem = Player_perspective_manager_visibility.new($BlackPoem)
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	$MessageLabel.visible = false

func _on_body_entered(body):
	if body.name in ["Player1", "Player2"]:
		is_player_inside_area = true
		player_inside = body
		$MessageLabel.visible = true
		

func _on_body_exited(body):
	if body.name in ["Player1", "Player2"]:
		is_player_inside_area = false
		$MessageLabel.visible = false
		if is_book_opened and player_inside != null:
			is_book_opened = false
			player_inside.get_node("Camera2D").make_current()
		player_inside = null

func _process(delta):
	if is_player_inside_area and Input.is_action_just_pressed("Interact"):
		is_book_opened = !is_book_opened
		if player_inside != null:
			if is_book_opened:
				$Camera2D.make_current()
			else:
				player_inside.get_node("Camera2D").make_current()

func update_poem_visibility(show):
	pass
	$BlackPoem.visible = show and player_inside.name == "Player1"
	$RedPoem.visible = show and player_inside.name == "Player2"
