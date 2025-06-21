extends GutTest

func before_each():
	await get_tree().process_frame

func test_gatling_gun_lvl_1_tower_id():
	var gatling_gun_lvl_1_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.GATLING_GUN_LVL_1].instantiate()
	add_child_autofree(gatling_gun_lvl_1_tower)
	assert_true(gatling_gun_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.GATLING_GUN_LVL_1, "Expected gatling_gun_LVL_1 tower ID to be gatling_gun_LVL_1")
	gatling_gun_lvl_1_tower.queue_free()

func test_gatling_gun_lvl_2_tower_id():
	var gatling_gun_lvl_2_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.GATLING_GUN_LVL_2].instantiate()
	add_child_autofree(gatling_gun_lvl_2_tower)
	assert_true(gatling_gun_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.GATLING_GUN_LVL_2, "Expected gatling_gun_LVL_2 tower ID to be gatling_gun_LVL_2")
	gatling_gun_lvl_2_tower.queue_free()
