extends GutTest

func before_each():
	await get_tree().process_frame

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

func test_black_marble_lvl_4_tower_id():
	var black_marble_lvl_4_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4].instantiate()
	add_child_autofree(black_marble_lvl_4_tower)
	assert_true(black_marble_lvl_4_tower.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4, "Expected BLACK_MARBLE_LVL_4 tower ID to be BLACK_MARBLE_LVL_4")
	black_marble_lvl_4_tower.queue_free()

func test_black_marble_lvl_5_tower_id():
	var black_marble_lvl_5_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_5].instantiate()
	add_child_autofree(black_marble_lvl_5_tower)
	assert_true(black_marble_lvl_5_tower.TOWER_ID == TowerConstants.TowerIDs.BLACK_MARBLE_LVL_5, "Expected BLACK_MARBLE_LVL_5 tower ID to be BLACK_MARBLE_LVL_5")
	black_marble_lvl_5_tower.queue_free()