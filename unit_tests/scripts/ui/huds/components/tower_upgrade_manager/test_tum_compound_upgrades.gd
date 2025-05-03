extends GutTest

func before_each():
    # Process frame to ensure cleanup has completed
    await get_tree().process_frame

## Simulate situation where there are no viable compound upgrade towers
func test_no_viable_compound_upgrades():
    # Create loose instance of tower upgrade manager
    var test_tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
    add_child_autofree(test_tower_upgrade_manager)

    # Create test instance of awaiting tower count dict
    var test_awaiting_selection_tower_count: Dictionary[TowerConstants.TowerIDs, int] = {
        TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: 1
    }

    # Create selected tower ID
    var test_selected_tower_id: TowerConstants.TowerIDs = TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1

    # Fetch selected list of viable compound upgrade towers
    var acquired_viable_upgrade_tower_ids: Array[TowerConstants.TowerIDs] = test_tower_upgrade_manager.viable_compound_upgrade_tower_ids(
        test_selected_tower_id,
        test_awaiting_selection_tower_count)

    # Simulate expected list of viable compound upgrade towers
    var expected_tower_id_arr: Array[TowerConstants.TowerIDs] = []

    assert_eq(acquired_viable_upgrade_tower_ids, expected_tower_id_arr)

    # Clean up
    test_tower_upgrade_manager.queue_free()

## Simulate situation where there are TWO towers of the same type that are awaiting selection.
## A level 1 selected tower is used because we want to create a situation where multiple 
## potential upgrades exist, thus eliminating a situation where there is only one possible option
## with which to begin.
## We should expect an array with a single candidate for possible upgrade towers.
func test_viable_compound_upgrade_from_two_level_1_towers():
    # Create loose instance of tower upgrade manager
    var test_tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
    add_child_autofree(test_tower_upgrade_manager)

    # Create test instance of awaiting tower count dict
    var test_awaiting_selection_tower_count: Dictionary[TowerConstants.TowerIDs, int] = {
        TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: 2
    }

    # Create selected tower ID
    var test_selected_tower_id: TowerConstants.TowerIDs = TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1

    # Fetch selected list of viable compound upgrade towers
    var acquired_viable_upgrade_tower_ids: Array[TowerConstants.TowerIDs] = test_tower_upgrade_manager.viable_compound_upgrade_tower_ids(
        test_selected_tower_id,
        test_awaiting_selection_tower_count)

    # Simulate expected list of viable compound upgrade towers
    var expected_tower_id_arr: Array[TowerConstants.TowerIDs] = [TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2]

    assert_eq(acquired_viable_upgrade_tower_ids, expected_tower_id_arr)

    # Clean up
    test_tower_upgrade_manager.queue_free()


## Simulate situation where there are THREE towers of the same type that are awaiting selection.
## A level 1 selected tower is used because we want to create a situation where multiple 
## potential upgrades exist.
## We should expect an array with two candidates for possible upgrade towers.
func test_viable_compound_upgrade_from_two_towers():
    # Create loose instance of tower upgrade manager
    var test_tower_upgrade_manager: TowerUpgradeManager = TowerUpgradeManager.new()
    add_child_autofree(test_tower_upgrade_manager)

    # Create test instance of awaiting tower count dict
    var test_awaiting_selection_tower_count: Dictionary[TowerConstants.TowerIDs, int] = {
        TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: 3
    }

    # Create selected tower ID
    var test_selected_tower_id: TowerConstants.TowerIDs = TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1

    # Fetch selected list of viable compound upgrade towers
    var acquired_viable_upgrade_tower_ids: Array[TowerConstants.TowerIDs] = test_tower_upgrade_manager.viable_compound_upgrade_tower_ids(
        test_selected_tower_id,
        test_awaiting_selection_tower_count)

    # Simulate expected list of viable compound upgrade towers
    var expected_tower_id_arr: Array[TowerConstants.TowerIDs] = [TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2, TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3]

    assert_eq(acquired_viable_upgrade_tower_ids, expected_tower_id_arr)

    # Clean up
    test_tower_upgrade_manager.queue_free()