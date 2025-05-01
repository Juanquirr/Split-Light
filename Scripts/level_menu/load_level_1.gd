extends Area2D

func _ready():
	print("Área activa y lista para recibir clics")

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton and event.pressed:
		# TODO PANEL Y OTRAS COSAS
		print("¡Clic detectado en el planeta!")
		SceneManager.change_to_scene(SceneManager.GameScenes.LEVEL_1)
