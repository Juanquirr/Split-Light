extends RichTextLabel

func _process(delta: float) -> void:
	var time_remaining = GetFinalTime.get_final_time()
	var minutes = int(time_remaining / 60)
	var seconds = int(time_remaining) % 60
	var milliseconds = int((time_remaining - int(time_remaining)) * 100)
	text ="Remainig Time: " + "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
