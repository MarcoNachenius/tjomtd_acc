extends GutTest

func before_each():
	await get_tree().process_frame

func test_sam_site_lvl_1_tower_id():
	var sam_site_lvl_1_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.SAM_SITE_LVL_1].instantiate()
	add_child_autofree(sam_site_lvl_1_tower)
	assert_true(sam_site_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.SAM_SITE_LVL_1, "Expected SAM_SITE_LVL_1 tower ID to be SAM_SITE_LVL_1")
	sam_site_lvl_1_tower.queue_free()

func test_sam_site_lvl_2_tower_id():
	var sam_site_lvl_2_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.SAM_SITE_LVL_2].instantiate()
	add_child_autofree(sam_site_lvl_2_tower)
	assert_true(sam_site_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.SAM_SITE_LVL_2, "Expected SAM_SITE_LVL_2 tower ID to be SAM_SITE_LVL_2")
	sam_site_lvl_2_tower.queue_free()

func test_sam_site_lvl_3_tower_id():
	var sam_site_lvl_3_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.SAM_SITE_LVL_3].instantiate()
	add_child_autofree(sam_site_lvl_3_tower)
	assert_true(sam_site_lvl_3_tower.TOWER_ID == TowerConstants.TowerIDs.SAM_SITE_LVL_3, "Expected SAM_SITE_LVL_3 tower ID to be SAM_SITE_LVL_3")
	sam_site_lvl_3_tower.queue_free()