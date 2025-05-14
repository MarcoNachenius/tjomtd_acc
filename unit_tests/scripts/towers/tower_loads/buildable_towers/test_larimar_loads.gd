extends GutTest

func before_each():
	await get_tree().process_frame


func test_larimar_lvl_1_tower_id():
	var larimar_lvl_1_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.LARIMAR_LVL_1].instantiate()
	add_child_autofree(larimar_lvl_1_tower)
	assert_true(larimar_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.LARIMAR_LVL_1, "Expected LARIMAR_LVL_1 tower ID to be LARIMAR_LVL_1")
	larimar_lvl_1_tower.queue_free()
