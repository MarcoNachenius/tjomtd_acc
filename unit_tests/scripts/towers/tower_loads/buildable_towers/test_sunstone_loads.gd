extends GutTest

func before_each():
	await get_tree().process_frame


func test_sunstone_lvl_1_tower_id():
	var sunstone_lvl_1_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_1].instantiate()
	add_child_autofree(sunstone_lvl_1_tower)
	assert_true(sunstone_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.SUNSTONE_LVL_1, "Expected SUNSTONE_LVL_1 tower ID to be SUNSTONE_LVL_1")
	sunstone_lvl_1_tower.queue_free()

func test_sunstone_lvl_2_tower_id():
	var sunstone_lvl_2_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_2].instantiate()
	add_child_autofree(sunstone_lvl_2_tower)
	assert_true(sunstone_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.SUNSTONE_LVL_2, "Expected SUNSTONE_LVL_2 tower ID to be SUNSTONE_LVL_2")
	sunstone_lvl_2_tower.queue_free()

func test_sunstone_lvl_3_tower_id():
	var sunstone_lvl_3_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_3].instantiate()
	add_child_autofree(sunstone_lvl_3_tower)
	assert_true(sunstone_lvl_3_tower.TOWER_ID == TowerConstants.TowerIDs.SUNSTONE_LVL_3, "Expected SUNSTONE_LVL_3 tower ID to be SUNSTONE_LVL_3")
	sunstone_lvl_3_tower.queue_free()

func test_sunstone_lvl_4_tower_id():
	var sunstone_lvl_4_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_4].instantiate()
	add_child_autofree(sunstone_lvl_4_tower)
	assert_true(sunstone_lvl_4_tower.TOWER_ID == TowerConstants.TowerIDs.SUNSTONE_LVL_4, "Expected SUNSTONE_LVL_4 tower ID to be SUNSTONE_LVL_4")
	sunstone_lvl_4_tower.queue_free()

func test_sunstone_lvl_5_tower_id():
	var sunstone_lvl_5_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SUNSTONE_LVL_5].instantiate()
	add_child_autofree(sunstone_lvl_5_tower)
	assert_true(sunstone_lvl_5_tower.TOWER_ID == TowerConstants.TowerIDs.SUNSTONE_LVL_5, "Expected SUNSTONE_LVL_5 tower ID to be SUNSTONE_LVL_5")
	sunstone_lvl_5_tower.queue_free()