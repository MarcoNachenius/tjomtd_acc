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
