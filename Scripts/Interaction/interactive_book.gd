extends Area2D

var players_inside = []
var open_book_for_player = {}

var visibility_red_poem
var visibility_black_poem

func _ready():
	visibility_red_poem = Player_perspective_manager_visibility.new($RedPoem)
	visibility_black_poem = Player_perspective_manager_visibility.new($BlackPoem)
	visibility_black_poem.disable()
	visibility_red_poem.disable()

func _on_body_entered(body):
	if body.name.begins_with("Player"):
		players_inside.append(body)
		update_poem_visibility()

func _on_body_exited(body):
	if body in players_inside:
		players_inside.erase(body)
		if body in open_book_for_player:
			open_book_for_player.erase(body)
		update_poem_visibility()

func _process(_delta):
	if Input.is_action_just_pressed("Interact"):
		for player in players_inside:
			if player.is_active_player():
				if player in open_book_for_player:
					InputManager.unblock_action("switch_player")
					player.set_process_input(true)
					player.set_physics_process(true)
					open_book_for_player.erase(player)
					player.get_node("Camera2D").enabled = true
					player.get_node("Camera2D").make_current()
					$Camera2D.enabled = false
				else:
					InputManager.block_action("switch_player")
					$Camera2D.enabled = true
					$Camera2D.make_current()
					open_book_for_player[player] = true
					player.set_process_input(false)
					player.set_physics_process(false)
					player.get_node("Camera2D").enabled = false
				update_poem_visibility()

func update_poem_visibility():
	visibility_black_poem.disable()
	visibility_red_poem.disable()

	for player in open_book_for_player:
		if player.name == "Player1":
			visibility_black_poem.enable()
		elif player.name == "Player2":
			visibility_red_poem.enable()
