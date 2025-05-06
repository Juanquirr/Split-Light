extends Control

var animation_player: AnimationPlayer

@onready var level1_btn = $Level1/Level1Button
@onready var level2_btn = $Level2/Level2Button
@onready var level3_btn = $Level3/Level3Button
@onready var level4_btn = $Level4/Level4Button
@onready var level5_btn = $Level5/Level5Button

func _enter_tree():
	animation_player = $"FadeInAnimation"
	animation_player.play("fade_in")
	animation_player.seek(0.0, true)
	animation_player.stop()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _ready():
	animation_player.play("fade_in")
	await wait(2.8)
	level1_btn.visible = true
	level2_btn.visible = true
	level3_btn.visible = true
	level4_btn.visible = true
	level5_btn.visible = true
