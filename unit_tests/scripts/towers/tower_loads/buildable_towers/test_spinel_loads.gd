extends GutTest

func before_each():
	await get_tree().process_frame


func test_spinel_lvl_1_tower_id():
	var spinel_lvl_1_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.SPINEL_LVL_1].instantiate()
	add_child_autofree(spinel_lvl_1_tower)
	assert_true(spinel_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.SPINEL_LVL_1, "Expected SPINEL_LVL_1 tower ID to be SPINEL_LVL_1")
	spinel_lvl_1_tower.queue_free()
