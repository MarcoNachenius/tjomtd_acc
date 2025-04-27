extends GutTest

func before_each():
    await get_tree().process_frame

func test_barricade_tower_id():
    var barricade_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BARRICADE].instantiate()
    add_child_autofree(barricade_tower)
    assert_true(barricade_tower.TOWER_ID == TowerConstants.TowerIDs.BARRICADE, "Expected BARRICADE tower ID to be BARRICADE")
    barricade_tower.queue_free()

func test_black_marble_lvl_1_tower_id():
    var black_marble_lvl_1_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()
    add_child_autofree(black_marble_lvl_1_tower)
    assert_true(black_marble_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1, "Expected BLACK_MARBLE_LVL_1 tower ID to be BLACK_MARBLE_LVL_1")
    black_marble_lvl_1_tower.queue_free()

func test_black_marble_lvl_2_tower_id():
    var black_marble_lvl_2_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2].instantiate()
    add_child_autofree(black_marble_lvl_2_tower)
    assert_true(black_marble_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2, "Expected BLACK_MARBLE_LVL_2 tower ID to be BLACK_MARBLE_LVL_2")
    black_marble_lvl_2_tower.queue_free()

func test_black_marble_lvl_3_tower_id():
    var black_marble_lvl_3_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3].instantiate()
    add_child_autofree(black_marble_lvl_3_tower)
    assert_true(black_marble_lvl_3_tower.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3, "Expected BLACK_MARBLE_LVL_3 tower ID to be BLACK_MARBLE_LVL_3")
    black_marble_lvl_3_tower.queue_free()

func test_bismuth_lvl_1_tower_id():
    var bismuth_lvl_1_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
    add_child_autofree(bismuth_lvl_1_tower)
    assert_true(bismuth_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.BISMUTH_LVL_1, "Expected BISMUTH_LVL_1 tower ID to be BISMUTH_LVL_1")
    bismuth_lvl_1_tower.queue_free()

func test_larimar_lvl_1_tower_id():
    var larimar_lvl_1_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
    add_child_autofree(larimar_lvl_1_tower)
    assert_true(larimar_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.LARIMAR_LVL_1, "Expected LARIMAR_LVL_1 tower ID to be LARIMAR_LVL_1")
    larimar_lvl_1_tower.queue_free()