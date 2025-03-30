extends Sprite2D

var key: Node  
var target_scene: SceneManager.SCENES

func init(target_scene: SceneManager.SCENES, key = null ) -> void:
	self.key = key  
	self.target_scene = target_scene 
	
func _process(_delta):
	if Input.is_action_just_pressed("Interact") && (key == null || key.get_key_status()):
		SceneManager.change_to_scene(self.target_scene)
