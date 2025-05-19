extends Control

@export var expected = [0, 0, 0]
@onready var animation_player = $"../../../AnimationLevel2"
@onready var player1 = $"../../../Characters/Player1"

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
@onready var tries_label = $TriesLabel
var tries_left = 3

func _ready():
	check_button.pressed.connect(_on_check_pressed)
	
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

func _on_check_pressed():
	if tries_left <= 0:
		return

	var correct = true

	for i in range(3):
		if digits[i]["value"] != expected[i]:
			correct = false
			break

	if correct:
		result_label.text = "Correct"
		result_label.add_theme_color_override("font_color", Color.GREEN)
		check_button.disabled = true
		player1.visible = false
		animation_player.current_animation = "spaceship_ship"
		animation_player.play("spaceship_ship")
		
	else:
		tries_left -= 1
		tries_label.text = "Tries: %d" % tries_left

		if tries_left == 0:
			result_label.text = "Game Over"
			result_label.add_theme_color_override("font_color", Color.RED)
			check_button.disabled = true
		else:
			result_label.text = "Incorrect"
			result_label.add_theme_color_override("font_color", Color.RED)

func change_expected_value(value):
	expected = value
