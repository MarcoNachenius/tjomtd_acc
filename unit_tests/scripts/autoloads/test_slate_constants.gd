extends GutTest

func before_each():
	await get_tree().physics_frame

func test_slate_requires_upgrades_into_allignment():
	for tower_id in SlateConstants.TOWER_UPGRADES_INTO_SLATES.keys():
		for slate_id in SlateConstants.TOWER_UPGRADES_INTO_SLATES[tower_id]:
			var slate_name: String = SlateDescriptions.SLATE_NAMES[slate_id]
			var tower_name: String = TowerDescriptions.TOWER_NAMES[tower_id]
			assert_true(SlateConstants.REQUIRES_TOWERS[slate_id].has(tower_id), "%s requires %s, and %s upgrades into it." % [slate_name, tower_name, tower_name])
