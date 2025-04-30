extends Control

var animation_player: AnimationPlayer

func _enter_tree():
	animation_player = get_node("FadeInAnimation")
	animation_player.play("fade_in")
	animation_player.seek(0.0, true)
	animation_player.stop()

func _ready():
	animation_player.play("fade_in")
