extends Node

enum GameScenes {
	MAIN_MENU,
	LEVEL_SELECTOR,
	LEVEL_1,
	LEVEL_1_COMPLETED,
	GAME_OVER
}

const SCENE_LIST = {
	GameScenes.MAIN_MENU: "main_menu",
	GameScenes.LEVEL_SELECTOR: "level_selection_menu",
	GameScenes.LEVEL_1: "level_1",
	GameScenes.LEVEL_1_COMPLETED: "level_1_completed",
	GameScenes.GAME_OVER: "game_over_menu"
}

const SCENES_PATH = "res://Scenes/"

func get_scene(scene: GameScenes) -> String:
	if scene in SCENE_LIST:
		return SCENES_PATH + SCENE_LIST[scene] + ".tscn"
	else:
		push_error("Scene %s not found in SCENE_LIST" % scene)
		return ""

func change_to_scene(scene: GameScenes):
	var scene_path = get_scene(scene)
	if scene_path != "":
		var error = get_tree().change_scene_to_file(scene_path)
		if error != OK:
			push_error("Failed to change to scene: %s" % scene_path)
	else:
		push_error("Cannot change to invalid scene: %s" % scene)
