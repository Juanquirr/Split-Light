extends Node

enum SCENES {
	MAIN_MENU,
	LEVEL_SELECTOR,
	LEVEL_1,
	LEVEL_1_COMPLETED,
	GAME_OVER
}

const SCENE_LIST = {
	SCENES.MAIN_MENU: "main_menu",
	SCENES.LEVEL_SELECTOR: "level_menu",
	SCENES.LEVEL_1: "level_1",
	SCENES.LEVEL_1_COMPLETED: "level_1_completed",
	SCENES.GAME_OVER: "game_over_menu"
}

const SCENES_PATH = "res://Scenes/"

func get_scene(scene: int) -> String:
	if scene in SCENE_LIST:
		return SCENES_PATH + SCENE_LIST[scene] + ".tscn"
	else:
		push_error("Scene %s not found in SCENE_LIST" % scene)
		return ""

func change_to_scene(scene: int):
	var scene_path = get_scene(scene)
	if scene_path != "":
		var error = get_tree().change_scene_to_file(scene_path)
		if error != OK:
			push_error("Failed to change to scene: %s" % scene_path)
	else:
		push_error("Cannot change to invalid scene: %s" % scene)
