extends Node2D

@onready var first_item = $first_item_solution
@onready var second_item = $second_item_solution
@onready var third_item = $third_item_solution
@onready var items_list := [first_item, second_item, third_item]
@onready var rotation_puzzle = $RotationPuzzle


var link_dict := {}

func _ready() -> void:
	randomize()
	await get_tree().process_frame
	sync_rotations_and_links()
	generate_random_solution()


func generate_random_solution():
	for index in range(items_list.size()):
		var item = items_list[index]
		var degree = get_degrees(item.sprite_rotation)
		for i in range(get_random_up_to(4)):
			item.rotate_90_degrees()
		if get_degrees(item.sprite_rotation) - degree < 0.5:
			item.rotate_90_degrees()
	rotation_puzzle.set_degree_target_list([get_degrees(first_item.sprite_rotation),get_degrees(second_item.sprite_rotation),get_degrees(third_item.sprite_rotation) ])
	
	

func sync_rotations_and_links():
	for index in range(items_list.size()):
		var item = items_list[index]
		items_list[index].sprite_rotation = rotation_puzzle.items_list[index].sprite_rotation
		items_list[index].rotation_degrees = rotation_puzzle.items_list[index].sprite_rotation
		link_dict[item] = items_list[rotation_puzzle.link_list_index[index]]

func get_degrees(degree):
	return abs(int(fmod(degree - 142.2, 360.0)))


func get_random_up_to(limit: int) -> int:
	if limit <= 0:
		push_error("The limit must be greater than 0")
		return 0
	return randi() % (limit + 1)


func on_child_changed(child):
	if link_dict[child] != null:
		link_dict[child].rotate_90_degrees_silent()
