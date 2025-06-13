extends GutTest

func before_each():
	await get_tree().process_frame

func test_ice_shard_lvl_1_tower_id():
	var ice_shard_lvl_1_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.ICE_SHARD_LVL_1].instantiate()
	add_child_autofree(ice_shard_lvl_1_tower)
	assert_true(ice_shard_lvl_1_tower.TOWER_ID == TowerConstants.TowerIDs.ICE_SHARD_LVL_1, "Expected ICE_SHARD_LVL_1 tower ID to be ICE_SHARD_LVL_1")
	ice_shard_lvl_1_tower.queue_free()

func test_ice_shard_lvl_2_tower_id():
	var ice_shard_lvl_2_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.ICE_SHARD_LVL_2].instantiate()
	add_child_autofree(ice_shard_lvl_2_tower)
	assert_true(ice_shard_lvl_2_tower.TOWER_ID == TowerConstants.TowerIDs.ICE_SHARD_LVL_2, "Expected ICE_SHARD_LVL_2 tower ID to be ICE_SHARD_LVL_2")
	ice_shard_lvl_2_tower.queue_free()

func test_ice_shard_lvl_3_tower_id():
	var ice_shard_lvl_3_tower: Tower = TowerConstants.UPGRADE_TOWER_PRELOADS[TowerConstants.TowerIDs.ICE_SHARD_LVL_3].instantiate()
	add_child_autofree(ice_shard_lvl_3_tower)
	assert_true(ice_shard_lvl_3_tower.TOWER_ID == TowerConstants.TowerIDs.ICE_SHARD_LVL_3, "Expected ICE_SHARD_LVL_3 tower ID to be ICE_SHARD_LVL_3")
	ice_shard_lvl_3_tower.queue_free()