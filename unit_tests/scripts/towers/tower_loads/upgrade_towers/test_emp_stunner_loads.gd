extends GutTest

func before_each():
	await get_tree().process_frame

func test_emp_stunner_lvl_1_tower_id():
	var emp_stunner_lvl_1_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.EMP_STUNNER_LVL_1].instantiate()
	add_child_autofree(emp_stunner_lvl_1_tower)
	assert_true(emp_stunner_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.EMP_STUNNER_LVL_1, "Expected EMP_STUNNER_LVL_1 tower ID to be EMP_STUNNER_LVL_1")
	emp_stunner_lvl_1_tower.queue_free()

func test_emp_stunner_lvl_2_tower_id():
	var emp_stunner_lvl_2_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.EMP_STUNNER_LVL_2].instantiate()
	add_child_autofree(emp_stunner_lvl_2_tower)
	assert_true(emp_stunner_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.EMP_STUNNER_LVL_2, "Expected EMP_STUNNER_LVL_2 tower ID to be EMP_STUNNER_LVL_2")
	emp_stunner_lvl_2_tower.queue_free()

func test_emp_stunner_lvl_3_tower_id():
	var emp_stunner_lvl_3_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.EMP_STUNNER_LVL_3].instantiate()
	add_child_autofree(emp_stunner_lvl_3_tower)
	assert_true(emp_stunner_lvl_3_tower.TOWER_ID == TowerConstants.TowerIDs.EMP_STUNNER_LVL_3, "Expected EMP_STUNNER_LVL_3 tower ID to be EMP_STUNNER_LVL_3")
	emp_stunner_lvl_3_tower.queue_free()