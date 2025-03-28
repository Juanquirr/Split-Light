extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		if not visible:
			show_pause_menu()
		else:
			unpause()

func show_pause_menu():
	pause()
	
	var camera = get_viewport().get_camera_2d()
	if camera:
		# Convertir la posición del centro de la cámara a coordenadas de pantalla
		var screen_center = camera.get_screen_center_position()
		
		# Ajustar la posición del menú para que esté centrado
		position = screen_center - Vector2(1572, 388)

func pause():
	get_tree().paused = true
	visible = true

func unpause():
	visible = false
	get_tree().paused = false
