extends GutTest

func before_each():
	await get_tree().process_frame

func test_sam_site_lvl_1_tower_id():
	var sam_site_lvl_1_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.SAM_SITE_LVL_1].instantiate()
	add_child_autofree(sam_site_lvl_1_tower)
	assert_true(sam_site_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.SAM_SITE_LVL_1, "Expected SAM_SITE_LVL_1 tower ID to be SAM_SITE_LVL_1")
	sam_site_lvl_1_tower.queue_free()

