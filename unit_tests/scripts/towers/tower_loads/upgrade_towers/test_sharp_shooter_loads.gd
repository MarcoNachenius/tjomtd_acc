extends GutTest

func before_each():
	await get_tree().process_frame

func test_sharp_shooter_1_tower_id():
	var sharp_shooter_1_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_1].instantiate()
	add_child_autofree(sharp_shooter_1_tower)
	assert_true(sharp_shooter_1_tower.TOWER_ID == TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_1, "Expected tower ID to be SHARP_SHOOTER_LVL_1")
	sharp_shooter_1_tower.queue_free()

func test_sharp_shooter_2_tower_id():
	var sharp_shooter_2_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_2].instantiate()
	add_child_autofree(sharp_shooter_2_tower)
	assert_true(sharp_shooter_2_tower.TOWER_ID == TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_2, "Expected tower ID to be SHARP_SHOOTER_LVL_2")
	sharp_shooter_2_tower.queue_free()