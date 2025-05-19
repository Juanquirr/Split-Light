extends Area2D

var players_inside: Array[PlayerInstance] = []
var open_lock_for_player = {}

func _on_body_entered(body: Node2D):
	print(body.name)
	if is_instance_of(body, PlayerInstance):
		players_inside.append(body)

func _on_body_exited(body: Node2D):
	if body in players_inside:
		players_inside.erase(body)
		if body in open_lock_for_player:
			open_lock_for_player.erase(body)

func _process(_delta):
	if not Input.is_action_just_pressed("Interact"): return
	for player in players_inside:
		if not player.is_active_player(): continue
		if player in open_lock_for_player:
			InputManager.unblock_action("switch_player")
			player.set_process_input(true)
			player.set_physics_process(true)
			open_lock_for_player.erase(player)
			player.get_node("Camera2D").enabled = true
			player.get_node("Camera2D").make_current()
			$"../../CodeLabel/Label/LockScreen/Camera2D".enabled = false
		else:
			InputManager.block_action("switch_player")
			$"../../CodeLabel/Label/LockScreen/Camera2D".enabled = true
			$"../../CodeLabel/Label/LockScreen/Camera2D".make_current()
			open_lock_for_player[player] = true
			player.set_process_input(false)
			player.set_physics_process(false)
			player.get_node("Camera2D").enabled = false
