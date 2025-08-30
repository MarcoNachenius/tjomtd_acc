extends GutTest

func before_each():
    await get_tree().process_frame
    await get_tree().physics_frame

func test_range_aura_buff():
    # TEST VALUES
    const STARTING_RANGE: int = 100
    const RANGE_INCREASE_FACTOR_VALUE: float = 0.2
    const EXPECTED_BUFFED_RANGE: int = 120
    const EXPECTED_RANGE_BUFF_AMOUNT: int = 20

    # Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
    # spawners or auras which might interfere with solely testing entry of a single range aura. 
    var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

    # Set primary projectile spawner's starting range
    test_tower.PRIMARY_PROJECTILE_SPAWNER.__detection_range = STARTING_RANGE

    # Add tower to scene
    add_child_autofree(test_tower)
    await get_tree().process_frame # let _ready run & signals connect
    await get_tree().physics_frame # register shapes this tick

    # Ensure tower's detection area has been created
    assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

    # Ensure starting range has been assigned as expected
    assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.__detection_range, STARTING_RANGE)

    # Ensure projectile spawner's initial range singleton has been properly assigned
    assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.INITIAL_RANGE, STARTING_RANGE)

    # Create range aura
    var range_aura: TowerRangeAura = TowerAuraConstants.TOWER_RANGE_AURA_PRELOAD.instantiate()
    range_aura.RANGE_INCREASE_FACTOR = RANGE_INCREASE_FACTOR_VALUE

    # Add range aura to scene
    add_child_autofree(range_aura)
    await get_tree().process_frame # added to tree
    await get_tree().physics_frame # shapes registered
    await get_tree().physics_frame # overlaps resolved & signals emitted

    # Ensure range aura and tower have the same global position, thus ensuring that
    # the range aura will be able to enter the tower's detection area.
    assert_eq(range_aura.global_position, test_tower.global_position, "Range aura and tower have the same global positions")

    # Ensure projectile spawner's range has been increased
    assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.__detection_range, EXPECTED_BUFFED_RANGE)

    # Ensure total range buff amount gets updated 
    assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.total_bonus_range(), EXPECTED_RANGE_BUFF_AMOUNT)

    # Ensure range aura is being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_range_auras.keys().has(range_aura), "Aura manager is tracking range aura")
    assert_eq(test_tower.TOWER_AURA_MANAGER.__active_range_auras[range_aura], EXPECTED_RANGE_BUFF_AMOUNT, "Range buff amount is being correctly tracked")

    # Remove range aura
    range_aura.queue_free()
    await get_tree().process_frame # node is actually freed here
    await get_tree().physics_frame # broadphase updates; exit likely emitted
    await get_tree().physics_frame # ensure everything settles

    # Ensure range aura is no longer being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_range_auras.is_empty(), "Range aura no longer being tracked by aura manager")

    # Ensure primary projectile spawner's range has been reset to initial amount
    assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.__detection_range, STARTING_RANGE)

    # Ensure bonus range amount is no longer being displayed
    assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.total_bonus_range(), 0, "Bonus range no longer being displayed")

    # Clean up
    test_tower.queue_free()