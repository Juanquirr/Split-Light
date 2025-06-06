extends Area2D

var players_inside: Array[PlayerInstance] = []
var open_book_for_player = {}

var visibility_red_poem: PlayerPerspectiveManagerInterface
var visibility_black_poem: PlayerPerspectiveManagerInterface

func _ready():
	self.visibility_red_poem = PlayerPerspectiveVisibilityManager.new($RedPoem)
	self.visibility_black_poem = PlayerPerspectiveVisibilityManager.new($BlackPoem)
	self.visibility_black_poem.disable()
	self.visibility_red_poem.disable()

func _on_body_entered(body: Node2D):
	if is_instance_of(body, PlayerInstance):
		players_inside.append(body)
		update_poem_visibility()

func _on_body_exited(body: Node2D):
	if body in players_inside:
		players_inside.erase(body)
		if body in open_book_for_player:
			open_book_for_player.erase(body)
		update_poem_visibility()

func play_book_open_sound():
	AudioManagerInstance.create_audio(
		SoundEffect.SOUND_EFFECT_TYPE.ON_BOOK_OPEN
	)

func play_book_close_sound():
	AudioManagerInstance.create_audio(
		SoundEffect.SOUND_EFFECT_TYPE.ON_BOOK_CLOSE
	)

func _process(_delta):
	if not Input.is_action_just_pressed("Interact"): return
	for player in players_inside:
		if not player.is_active_player(): continue
		if player in open_book_for_player:
			InputManager.unblock_action("switch_player")
			player.set_process_input(true)
			player.set_physics_process(true)
			open_book_for_player.erase(player)
			player.get_node("Camera2D").enabled = true
			player.get_node("Camera2D").make_current()
			$Camera2D.enabled = false
			self.play_book_close_sound()
		else:
			InputManager.block_action("switch_player")
			$Camera2D.enabled = true
			$Camera2D.make_current()
			open_book_for_player[player] = true
			player.set_process_input(false)
			player.set_physics_process(false)
			player.get_node("Camera2D").enabled = false
			self.play_book_open_sound()
			
		update_poem_visibility()

func update_poem_visibility():
	visibility_black_poem.disable()
	visibility_red_poem.disable()

	for player in open_book_for_player:
		if player.name == "Player1":
			visibility_black_poem.enable()
		elif player.name == "Player2":
			visibility_red_poem.enable()
