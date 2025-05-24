extends GutTest

func before_each():
	await get_tree().process_frame


func test_bismuth_lvl_1_tower_id():
	var bismuth_lvl_1_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_1].instantiate()
	add_child_autofree(bismuth_lvl_1_tower)
	assert_true(bismuth_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.BISMUTH_LVL_1, "Expected BISMUTH_LVL_1 tower ID to be BISMUTH_LVL_1")
	bismuth_lvl_1_tower.queue_free()

func test_bismuth_lvl_2_tower_id():
	var bismuth_lvl_2_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_2].instantiate()
	add_child_autofree(bismuth_lvl_2_tower)
	assert_true(bismuth_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.BISMUTH_LVL_2, "Expected BISMUTH_LVL_2 tower ID to be BISMUTH_LVL_2")
	bismuth_lvl_2_tower.queue_free()

func test_bismuth_lvl_3_tower_id():
	var bismuth_lvl_3_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_3].instantiate()
	add_child_autofree(bismuth_lvl_3_tower)
	assert_true(bismuth_lvl_3_tower.TOWER_ID == TowerConstants.TowerIDs.BISMUTH_LVL_3, "Expected BISMUTH_LVL_3 tower ID to be BISMUTH_LVL_3")
	bismuth_lvl_3_tower.queue_free()

func test_bismuth_lvl_4_tower_id():
	var bismuth_lvl_4_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_4].instantiate()
	add_child_autofree(bismuth_lvl_4_tower)
	assert_true(bismuth_lvl_4_tower.TOWER_ID == TowerConstants.TowerIDs.BISMUTH_LVL_4, "Expected BISMUTH_LVL_4 tower ID to be BISMUTH_LVL_4")
	bismuth_lvl_4_tower.queue_free()

func test_bismuth_lvl_5_tower_id():
	var bismuth_lvl_5_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BISMUTH_LVL_5].instantiate()
	add_child_autofree(bismuth_lvl_5_tower)
	assert_true(bismuth_lvl_5_tower.TOWER_ID == TowerConstants.TowerIDs.BISMUTH_LVL_5, "Expected BISMUTH_LVL_5 tower ID to be BISMUTH_LVL_5")
	bismuth_lvl_5_tower.queue_free()