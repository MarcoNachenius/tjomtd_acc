extends GutTest

func before_each():
	await get_tree().process_frame

func test_barricade_tower_id():
	var barricade_tower: Tower = TowerConstants.BUILD_TOWER_PRELOADS[TowerConstants.TowerIDs.BARRICADE].instantiate()
	add_child_autofree(barricade_tower)
	assert_true(barricade_tower.TOWER_ID == TowerConstants.TowerIDs.BARRICADE, "Expected BARRICADE tower ID to be BARRICADE")
	barricade_tower.queue_free()
