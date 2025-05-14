extends GutTest

func before_each():
	await get_tree().process_frame

func test_tombstone_lvl_1_tower_id():
	var tombstone_lvl_1_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.TOMBSTONE_LVL_1].instantiate()
	add_child_autofree(tombstone_lvl_1_tower)
	assert_true(tombstone_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.TOMBSTONE_LVL_1, "Expected TOMBSTONE_LVL_1 tower ID to be TOMBSTONE_LVL_1")
	tombstone_lvl_1_tower.queue_free()

