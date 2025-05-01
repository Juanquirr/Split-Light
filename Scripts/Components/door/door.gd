extends Area2D

class_name Door

var key: InteractiveKey  
var target_scene: SceneManager.SCENES
var players_inside: Array[PlayerInstance] = []

func init(init_target_scene: SceneManager.SCENES, init_key = null ) -> void:
	self.key = init_key  
	self.target_scene = init_target_scene 

func _process(_delta: float):
	if not InputManager.is_action_just_pressed("Interact"): return
	for player in self.players_inside:
		if player.is_active_player() && (key == null || key.get_key_status()):
			SceneManager.change_to_scene(self.target_scene)

func _on_body_entered(body: CharacterBody2D):
	if is_instance_of(body, PlayerInstance):
		players_inside.append(body)

func _on_body_exited(body: CharacterBody2D):
	if body in players_inside:
		players_inside.erase(body)
		
