extends Node2D

@onready var first_item = $first_item
@onready var second_item = $second_item
@onready var third_item = $third_item
@onready var items_list := [first_item, second_item, third_item]


var link_dict := {}
var link_list_index := {}
@export var degree_target_list := [0,0,0]  

signal rotation_puzzle_completed

func _ready() -> void:
	randomize()
	rotate_items_randomly()
	randomly_link_item_rotations()


func randomly_link_item_rotations():
	for index in range(items_list.size()):
		var item = items_list[index]
		var random_index = get_random_up_to(2)
		if random_index == index:
			link_dict[item] = items_list[(random_index + 1) % items_list.size()]
			link_list_index[index] = (random_index + 1) % items_list.size()
		else:
			link_dict[item] = items_list[random_index]
			link_list_index[index] = random_index

func rotate_items_randomly():
	var angles := [0, 90, 180, 270]
	for index in range(items_list.size()):
		var item = items_list[index]
		item.rotation_degrees += angles[get_random_up_to(3)]
		item.update_sprite_rotation()

func set_degree_target_list(target_list):
	degree_target_list = target_list


func get_random_up_to(limit: int) -> int:
	if limit <= 0:
		push_error("The limit must be greater than 0")
		return 0
	return randi() % (limit + 1)

func check_target_list():
	for index in range(items_list.size()):
		if abs(abs(int(fmod(items_list[index].sprite_rotation - 142.2, 360.0))) - abs(int(degree_target_list[index]))) > 0.5:
			return
	emit_signal("rotation_puzzle_completed")



func child_change(child):
	link_dict[child].rotate_90_degrees_silent()
	check_target_list()
