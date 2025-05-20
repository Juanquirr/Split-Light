extends Control

@export var expected = [0, 0, 0]
@onready var animation_player = $"../../../AnimationLevel2"
@onready var player1 = $"../../../Characters/Player1"
@onready var spaceship_bg := $"../../SpaceShipBGLock"
@onready var timer_component := $"../../../Mechanics/TimerLabel"


@onready var digits = [
	{
		"label": $DigitsContainer/Digit1/LabelValue,
		"plus": $DigitsContainer/Digit1/BtnPlus,
		"minus": $DigitsContainer/Digit1/BtnMinus,
		"value": 0
	},
	{
		"label": $DigitsContainer/Digit2/LabelValue,
		"plus": $DigitsContainer/Digit2/BtnPlus,
		"minus": $DigitsContainer/Digit2/BtnMinus,
		"value": 0
	},
	{
		"label": $DigitsContainer/Digit3/LabelValue,
		"plus": $DigitsContainer/Digit3/BtnPlus,
		"minus": $DigitsContainer/Digit3/BtnMinus,
		"value": 0
	},
]

@onready var result_label = $DigitsContainer/ResultLabel
@onready var check_button = $DigitsContainer/CheckButton
@onready var attempts_label = $TriesLabel
@export var attempts_left = 3

func _ready():
	check_button.pressed.connect(func(): _on_check_pressed.rpc())
	animation_player.connect("animation_finished", on_animation_finish)
	
	for digit in digits:
		digit["plus"].pressed.connect(func(): _change_digit(digit, 1))
		digit["minus"].pressed.connect(func(): _change_digit(digit, -1))
		_style_label(digit["label"])

func _change_digit(digit, delta):
	digit["value"] = (digit["value"] + delta) % 10
	if digit["value"] < 0:
		digit["value"] = 9
	var space = "          "
	digit["label"].text = space + str(digit["value"]) + space

func _style_label(label):
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color.WHITE
	label.add_theme_stylebox_override("normal", stylebox)
	label.add_theme_color_override("font_color", Color.BLACK)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

@rpc("any_peer", "call_local")
func _go_to_win_scene():
	timer_component.set_remaining_time()
	SceneManager.change_to_scene(SceneManager.GameScenes.LEVEL_2_COMPLETED)

func on_animation_finish(animation_name: String):
	if animation_name != "spaceship_ship": return
	_go_to_win_scene.rpc()
	
@rpc("any_peer", "call_local")
func _play_spaceship_animation():
	animation_player.current_animation = "spaceship_ship"
	animation_player.play("spaceship_ship")

@rpc("any_peer", "call_local")
func _on_lock_guess_correct():
	result_label.text = "Correct"
	result_label.add_theme_color_override("font_color", Color.GREEN)
	check_button.disabled = true
	player1.visible = false
	AudioManagerInstance.create_audio(SoundEffect.SOUND_EFFECT_TYPE.ON_TASK_COMPLETE_1)
	await wait(1)
	$Camera2D.enabled = false
	spaceship_bg.visible = false
	var spaceship_cam := $"../../../SpaceShip/Area2D/SpaceShip/SpaceshipEndingCam"
	spaceship_cam.enabled = true
	spaceship_cam.make_current()
	_play_spaceship_animation.rpc()

@rpc("any_peer", "call_local")
func _on_check_pressed():
	if attempts_left <= 0:
		return

	var correct = true
	print(expected)

	for i in range(3):
		if digits[i]["value"] != expected[i]:
			correct = false
			break

	if correct:
		self._on_lock_guess_correct.rpc()
	else:
		attempts_left -= 1
		attempts_label.text = "Attempts: %d" % attempts_left

		if attempts_left == 0:
			result_label.text = "Game Over"
			result_label.add_theme_color_override("font_color", Color.RED)
			check_button.disabled = true
		else:
			result_label.text = "Incorrect"
			result_label.add_theme_color_override("font_color", Color.RED)

func change_expected_value(value):
	expected = value
