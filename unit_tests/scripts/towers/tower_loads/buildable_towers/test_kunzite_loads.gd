extends GutTest

func before_each():
	await get_tree().process_frame


func test_kunzite_lvl_1_tower_id():
	var kunzite_lvl_1_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.KUNZITE_LVL_1].instantiate()
	add_child_autofree(kunzite_lvl_1_tower)
	assert_true(kunzite_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.KUNZITE_LVL_1, "Expected KUNZITE_LVL_1 tower ID to be KUNZITE_LVL_1")
	kunzite_lvl_1_tower.queue_free()

func test_kunzite_lvl_2_tower_id():
	var kunzite_lvl_2_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.KUNZITE_LVL_2].instantiate()
	add_child_autofree(kunzite_lvl_2_tower)
	assert_true(kunzite_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.KUNZITE_LVL_2, "Expected KUNZITE_LVL_2 tower ID to be KUNZITE_LVL_2")
	kunzite_lvl_2_tower.queue_free()

func test_kunzite_lvl_3_tower_id():
	var kunzite_lvl_3_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.KUNZITE_LVL_3].instantiate()
	add_child_autofree(kunzite_lvl_3_tower)
	assert_true(kunzite_lvl_3_tower.TOWER_ID == TowerConstants.TowerIDs.KUNZITE_LVL_3, "Expected KUNZITE_LVL_3 tower ID to be KUNZITE_LVL_3")
	kunzite_lvl_3_tower.queue_free()

func test_kunzite_lvl_4_tower_id():
	var kunzite_lvl_4_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.KUNZITE_LVL_4].instantiate()
	add_child_autofree(kunzite_lvl_4_tower)
	assert_true(kunzite_lvl_4_tower.TOWER_ID == TowerConstants.TowerIDs.KUNZITE_LVL_4, "Expected KUNZITE_LVL_4 tower ID to be KUNZITE_LVL_4")
	kunzite_lvl_4_tower.queue_free()

func test_kunzite_lvl_5_tower_id():
	var kunzite_lvl_5_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.KUNZITE_LVL_5].instantiate()
	add_child_autofree(kunzite_lvl_5_tower)
	assert_true(kunzite_lvl_5_tower.TOWER_ID == TowerConstants.TowerIDs.KUNZITE_LVL_5, "Expected KUNZITE_LVL_5 tower ID to be KUNZITE_LVL_5")
	kunzite_lvl_5_tower.queue_free()