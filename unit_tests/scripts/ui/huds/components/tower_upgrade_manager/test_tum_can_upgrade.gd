extends GutTest

func before_each():
    await get_tree().process_frame

func test_cannot_upgrade():
    # TEST TOWERS
    # ===========
    # Black Marble level 1
    var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
    add_child_autofree(black_marble_lvl_1)

    # Create test instance of upgrade manager
    var tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
    add_child_autofree(tower_upgrade_manager)

    # Create test array of towers
    var towers_array: Array[Tower] = [black_marble_lvl_1]

    # Call the function to test
    var can_upgrade: bool = tower_upgrade_manager.can_upgrade_to_tower(TowerConstants.TowerIDs.TOMBSTONE_LVL_1, towers_array)

    # Check that the count dictionary is empty
    assert_false(can_upgrade, "Expected can_upgrade to be false")

    # Clean up towers
    black_marble_lvl_1.queue_free()
    # Clean up upgrade manager
    tower_upgrade_manager.queue_free()

    # Process frame to ensure all nodes are freed
    await get_tree().process_frame

func test_can_upgrade():
    # TEST TOWERS
    # ===========
    # Black Marble level 1
    var black_marble_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
    add_child_autofree(black_marble_lvl_1)
    # Bismuth level 1
    var bismuth_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
    add_child_autofree(bismuth_lvl_1)
    # Larimar level 1
    var larimar_lvl_1: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
    add_child_autofree(larimar_lvl_1)

    # Create test instance of upgrade manager
    var tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
    add_child_autofree(tower_upgrade_manager)

    # Create test array of towers
    var towers_array: Array[Tower] = [black_marble_lvl_1, bismuth_lvl_1, larimar_lvl_1]

    # Call the function to test
    var can_upgrade: bool = tower_upgrade_manager.can_upgrade_to_tower(TowerConstants.TowerIDs.TOMBSTONE_LVL_1, towers_array)

    # Check that the count dictionary is empty
    assert_true(can_upgrade, "Expected can_upgrade to be true")

    # Clean up towers
    black_marble_lvl_1.queue_free()
    # Clean up upgrade manager
    tower_upgrade_manager.queue_free()

    # Process frame to ensure all nodes are freed
    await get_tree().process_frame