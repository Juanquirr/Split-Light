extends Label



func _ready():
	randomize()
	var number = randi() % 1000  # Número entre 0 y 999
	var roman = to_roman(number)
	text = roman
	if get_child_count()>0:
		get_child(0).change_expected_value(separed_digit(number))

func separed_digit(numero: int) -> Array:
	if numero < 100 or numero > 999:
		push_error("El número debe tener exactamente tres dígitos")
		return []

	var centenas = numero / 100
	var decenas = (numero % 100) / 10
	var unidades = numero % 10

	return [centenas, decenas, unidades]

func to_roman(number):
	if number == 0:
		return "N"

	var roman_numerals = [
		[900, "CM"], [500, "D"], [400, "CD"], [100, "C"],
		[90, "XC"], [50, "L"], [40, "XL"], [10, "X"],
		[9, "IX"], [5, "V"], [4, "IV"], [1, "I"]
	]

	var result = ""
	var remaining = number

	for pair in roman_numerals:
		var value = pair[0]
		var numeral = pair[1]
		while remaining >= value:
			result += numeral
			remaining -= value

	return result
