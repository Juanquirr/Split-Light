extends Sprite2D

var players_inside: Array[PlayerInstance] = []
var sprite_rotation := 142.2


func update_sprite_rotation():
	sprite_rotation = rotation_degrees

@rpc("any_peer","call_remote")
func rotate_90_degrees() -> void:
	var tween := create_tween()
	sprite_rotation += 90
	var target_rotation = sprite_rotation
	tween.tween_property(self, "rotation_degrees", target_rotation, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	get_parent().child_change(self)

func rotate_90_degrees_silent() -> void:
	var tween := create_tween()
	sprite_rotation += 90
	var target_rotation = sprite_rotation
	tween.tween_property(self, "rotation_degrees", target_rotation, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _process(_delta):
	if not Input.is_action_just_pressed("Interact"): return
	for player in players_inside:
		if not player.is_active_player(): continue
		rotate_90_degrees()
		
		if MultiplayerManager.IS_MULTIPLAYER:
			rotate_90_degrees.rpc_id(1)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_instance_of(body, PlayerInstance):
		players_inside.append(body)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in players_inside:
		players_inside.erase(body)
