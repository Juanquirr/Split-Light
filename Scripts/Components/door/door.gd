extends Area2D

class_name Door

var key: Node  
var target_scene: SceneManager.SCENES
var players_inside = []

func init(target_scene: SceneManager.SCENES, key = null ) -> void:
	self.key = key  
	self.target_scene = target_scene 
	
func _process(_delta):
	if InputManager.is_action_just_pressed("Interact"):
		for player in players_inside:
				if player.is_active_player() && (key == null || key.get_key_status()):
					SceneManager.change_to_scene(self.target_scene)
		
		
func _on_body_entered(body):
	if body.name.begins_with("Player"):
		players_inside.append(body)
		

func _on_body_exited(body):
	if body in players_inside:
		players_inside.erase(body)
		
