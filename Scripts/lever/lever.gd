extends Node2D

@onready var numberShadow = $"../../Lights/NumberShadow"
@onready var numberLight = $"../../Lights/NumberLight"

var activable_item : SwitchInteractiveInterface
var players_inside: Array[PlayerInstance] = []
var active := false

func _ready() -> void:
	if get_child_count() > 4:
		activable_item = get_child(4)

@rpc("any_peer", "call_remote")
func show_log_lights():
	$active_sprite.visible = false
	$inactive_sprite.visible = true
	numberShadow.visible = false
	numberLight.visible = true
	activate()

@rpc("any_peer", "call_remote")
func hide_log_lights():
	$inactive_sprite.visible = false
	$active_sprite.visible = true
	numberShadow.visible = true
	numberLight.visible = false
	desactivate()

func _process(_delta):
	if not Input.is_action_just_pressed("Interact"): return
	for player in players_inside:
		if not player.is_active_player(): continue
		if active:
			active = false
			hide_log_lights()
			if MultiplayerManager.IS_MULTIPLAYER and MultiplayerManager.IS_CLIENT:
				hide_log_lights.rpc_id(1)
		else:
			active = true
			show_log_lights()
			if MultiplayerManager.IS_MULTIPLAYER and MultiplayerManager.IS_CLIENT:
				show_log_lights.rpc_id(1)

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
