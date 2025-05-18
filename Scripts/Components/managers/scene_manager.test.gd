extends GutTest

class TestSceneManager:
	extends GutTest
	
	func test_game_scenes_enum_values():
		# Verify all enum values exist and are correctly defined
		assert_not_null(SceneManager.GameScenes.MAIN_MENU, "MAIN_MENU scene should be available")
		assert_not_null(SceneManager.GameScenes.LEVEL_SELECTOR, "LEVEL_SELECTOR scene should be available")
		assert_not_null(SceneManager.GameScenes.LEVEL_1, "LEVEL_1 scene should be available")
		assert_not_null(SceneManager.GameScenes.LEVEL_1_COMPLETED, "LEVEL_1_COMPLETED scene should be available")
		assert_not_null(SceneManager.GameScenes.GAME_OVER, "GAME_OVER scene should be available")

	func test_scene_list_mapping():
		# Verify SCENE_LIST contains correct mappings
		assert_eq(SceneManager.SCENE_LIST[SceneManager.GameScenes.MAIN_MENU], "main_menu", "MAIN_MENU should map to 'main_menu'")
		assert_eq(SceneManager.SCENE_LIST[SceneManager.GameScenes.LEVEL_SELECTOR], "level_selection_menu", "LEVEL_SELECTOR should map to 'level_selection_menu'")
		assert_eq(SceneManager.SCENE_LIST[SceneManager.GameScenes.LEVEL_1], "Level 1/level_1", "LEVEL_1 should map to 'level_1'")
		assert_eq(SceneManager.SCENE_LIST[SceneManager.GameScenes.LEVEL_1_COMPLETED], "Level 1/level_1_completed", "LEVEL_1_COMPLETED should map to 'level_1_completed'")
		assert_eq(SceneManager.SCENE_LIST[SceneManager.GameScenes.GAME_OVER], "game_over_menu", "GAME_OVER should map to 'game_over_menu'")

	func test_scene_list_completeness():
		# Verify all enum values have a corresponding entry in SCENE_LIST
		for scene in SceneManager.GameScenes.values():
			assert_true(SceneManager.SCENE_LIST.has(scene), "SCENE_LIST should contain mapping for enum value %d" % scene)

	func test_scene_list_no_extra_keys():
		# Verify SCENE_LIST doesn't contain unexpected keys
		var expected_keys = SceneManager.GameScenes.values()
		for key in SceneManager.SCENE_LIST.keys():
			assert_true(key in expected_keys, "SCENE_LIST contains unexpected key: %d" % key)
		assert_eq(SceneManager.SCENE_LIST.size(), expected_keys.size(), "SCENE_LIST should have exactly %d entries" % expected_keys.size())
