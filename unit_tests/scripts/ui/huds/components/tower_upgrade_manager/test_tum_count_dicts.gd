extends GutTest

func before_each():
	await get_tree().process_frame

func test_tower_count_dict_empty():
	# Create test instance of upgrade manager
	var tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
	add_child_autofree(tower_upgrade_manager)

	# Create test array of towers
	var towers_array: Array[Tower] = []

	# Call the function to test
	var count_dict: Dictionary = tower_upgrade_manager._tower_count_dict(towers_array)

	# Check that the count dictionary is empty
	assert_true(count_dict.size() == 0)
	assert_true(count_dict == {})

	# Clean up upgrade manager
	tower_upgrade_manager.queue_free()


func test_tower_count_dict_single_tower():
	# TEST TOWERS
	# ===========
	# Black Marble level 1
	var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(black_marble_lvl_1)
	assert_true(black_marble_lvl_1.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1)

	# Create test instance of upgrade manager
	var tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
	add_child_autofree(tower_upgrade_manager)

	# Create test array of towers
	var towers_array: Array[Tower] = [black_marble_lvl_1]

	# Call the function to test
	var count_dict: Dictionary = tower_upgrade_manager._tower_count_dict(towers_array)

	# Create expected dictionary
	var expected_dict: Dictionary = {
		TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: 1
	}
	# Check that the count dictionary is empty
	assert_true(count_dict.size() == 1)
	assert_eq(count_dict, expected_dict, "Expected count dictionary to be {BLACK_MARBLE_LVL_1: 1}")

	# Clean up towers
	black_marble_lvl_1.queue_free()
	# Clean up upgrade manager
	tower_upgrade_manager.queue_free()

func test_tower_count_dict_two_of_same_tower_type():
	# TEST TOWERS
	# ===========
	# Black Marble level 1
	var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(black_marble_lvl_1)
	assert_true(black_marble_lvl_1.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1)

	# Create test instance of upgrade manager
	var tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
	add_child_autofree(tower_upgrade_manager)

	# Create test array of towers
	var towers_array: Array[Tower] = [black_marble_lvl_1, black_marble_lvl_1]

	# Call the function to test
	var count_dict: Dictionary = tower_upgrade_manager._tower_count_dict(towers_array)

	# Create expected dictionary
	var expected_dict: Dictionary = {
		TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: 2
	}
	# Check that the count dictionary is empty
	assert_true(count_dict.size() == 1)
	assert_eq(count_dict, expected_dict, "Expected count dictionary to be {BLACK_MARBLE_LVL_1: 2}")

	# Clean up towers
	black_marble_lvl_1.queue_free()
	# Clean up upgrade manager
	tower_upgrade_manager.queue_free()


func test_tower_count_dict_two_different_tower_types():
	# TEST TOWERS
	# ===========
	# Black Marble level 1
	var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(black_marble_lvl_1)
	assert_true(black_marble_lvl_1.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1)

	# Bismuth level 1
	var bismuth_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
	add_child_autofree(bismuth_lvl_1)
	assert_true(bismuth_lvl_1.TOWER_ID == TowerConstants.TowerIDs.BISMUTH_LVL_1)

	# Create test instance of upgrade manager
	var tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
	add_child_autofree(tower_upgrade_manager)

	# Create test array of towers
	var towers_array: Array[Tower] = [black_marble_lvl_1, bismuth_lvl_1]

	# Call the function to test
	var count_dict: Dictionary = tower_upgrade_manager._tower_count_dict(towers_array)

	# Create expected dictionary
	var expected_dict: Dictionary = {
		TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: 1,
		TowerConstants.TowerIDs.BISMUTH_LVL_1: 1
	}
	# Check that the count dictionary is empty
	assert_true(count_dict.size() == 2)
	assert_eq(count_dict, expected_dict, "Expected count dictionary to be {BLACK_MARBLE_LVL_1: 1, BISMUTH_LVL_1: 1}")

	# Clean up towers
	bismuth_lvl_1.queue_free()
	black_marble_lvl_1.queue_free()
	# Clean up upgrade manager
	tower_upgrade_manager.queue_free()

func test_built_tower_count_dict_empty_with_tower_awaiting_selection():
	# TEST TOWERS
	# ===========
	# Black Marble level 1
	var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(black_marble_lvl_1)
	assert_true(black_marble_lvl_1.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1)

	# Ensure the tower is in the AWAITING_SELECTION state
	assert_true(black_marble_lvl_1.get_state() == Tower.States.AWAITING_SELECTION)

	# Create test instance of upgrade manager
	var tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
	add_child_autofree(tower_upgrade_manager)

	# Create test array of towers
	var towers_array: Array[Tower] = [black_marble_lvl_1]

	# Call the function to test
	var count_dict: Dictionary = tower_upgrade_manager._built_tower_count_dict(towers_array)

	# Create expected dictionary
	var expected_dict: Dictionary[TowerConstants.TowerIDs, int] = {}
	# Check that the count dictionary is empty
	assert_true(count_dict.size() == 0)
	assert_eq(count_dict, expected_dict, "Expected count dictionary should be empty")

	# Clean up towers
	black_marble_lvl_1.queue_free()
	# Clean up upgrade manager
	tower_upgrade_manager.queue_free()

func test_built_tower_count_dict_single_tower():
	# TEST TOWERS
	# ===========
	# Black Marble level 1
	var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
	add_child_autofree(black_marble_lvl_1)
	assert_true(black_marble_lvl_1.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1)

	# Create test instance of upgrade manager
	var tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
	add_child_autofree(tower_upgrade_manager)

	# Create test array of towers
	var towers_array: Array[Tower] = [black_marble_lvl_1]

	# Change the state of the tower to BUILT
	black_marble_lvl_1.switch_state(Tower.States.BUILT)

	# Call the function to test
	var count_dict: Dictionary = tower_upgrade_manager._built_tower_count_dict(towers_array)

	# Create expected dictionary
	var expected_dict: Dictionary = {
		TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: 1
	}
	# Check that the count dictionary is empty
	assert_true(count_dict.size() == 1)
	assert_eq(count_dict, expected_dict, "Expected count dictionary to be {BLACK_MARBLE_LVL_1: 1}")

	# Clean up towers
	black_marble_lvl_1.queue_free()
	# Clean up upgrade manager
	tower_upgrade_manager.queue_free()
