extends Node2D

var activable_item : SwitchInteractiveInterface
var players_inside: Array[PlayerInstance] = []
var active := false
func _ready() -> void:
	if get_child_count() > 3:
		activable_item = get_child(3)

func _process(_delta):
	if not Input.is_action_just_pressed("Interact"): return
	for player in players_inside:
		if not player.is_active_player(): continue
		if active:
			active = false
			$inactive_sprite.visible = false
			$active_sprite.visible = true
			desactivate()
		else:
			active = true
			$active_sprite.visible = false
			$inactive_sprite.visible = true
			activate()
		
			

func activate():
	activable_item.active()

func desactivate():
	activable_item.desactive()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if is_instance_of(body, PlayerInstance):
		players_inside.append(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in players_inside:
		players_inside.erase(body)
