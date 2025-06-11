extends GutTest

func before_each():
	await get_tree().process_frame

func test_lava_pool_lvl_1_tower_id():
	var lava_pool_lvl_1_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.LAVA_POOL_LVL_1].instantiate()
	add_child_autofree(lava_pool_lvl_1_tower)
	assert_true(lava_pool_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.LAVA_POOL_LVL_1, "Expected LAVA_POOL_LVL_1 tower ID to be LAVA_POOL_LVL_1")
	lava_pool_lvl_1_tower.queue_free()

func test_lava_pool_lvl_2_tower_id():
	var lava_pool_lvl_2_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.LAVA_POOL_LVL_2].instantiate()
	add_child_autofree(lava_pool_lvl_2_tower)
	assert_true(lava_pool_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.LAVA_POOL_LVL_2, "Expected LAVA_POOL_LVL_2 tower ID to be LAVA_POOL_LVL_2")
	lava_pool_lvl_2_tower.queue_free()

func test_lava_pool_lvl_3_tower_id():
	var lava_pool_lvl_3_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.LAVA_POOL_LVL_3].instantiate()
	add_child_autofree(lava_pool_lvl_3_tower)
	assert_true(lava_pool_lvl_3_tower.TOWER_ID == TowerConstants.TowerIDs.LAVA_POOL_LVL_3, "Expected LAVA_POOL_LVL_3 tower ID to be LAVA_POOL_LVL_3")
	lava_pool_lvl_3_tower.queue_free()