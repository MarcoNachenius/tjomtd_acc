extends GutTest

# TESTED MISSILE SPAWNERS:
# =======================
#   - SingleMissileSpawner
#   - RandomRicochetMissileSpawner
#   - TargetedRicochetMissileSpawner
#   - MultiRandomRicochetMissileSpawner
#   - StarRandomRicochetMissileSpawner
#   - MultiTargetTargetedRicochetMissileSpawner


func before_each():
    await get_tree().process_frame
    await get_tree().physics_frame

func test_damage_aura_single_hit_missile_spanwer_buff():
    # TEST VALUES
    const STARTING_DAMAGE: int = 100
    const DAMAGE_INCREASE_FACTOR_VALUE: float = 0.2
    const EXPECTED_BUFFED_DAMAGE: int = 120
    const EXPECTED_DAMAGE_BUFF_AMOUNT: int = 20

    # Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
    # spawners or auras which might interfere with solely testing entry of a single damage aura. 
    var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

    # Replace tower's primary projectile spanwer with SingleMissileSpawner 
    test_tower.PRIMARY_PROJECTILE_SPAWNER.queue_free()

    # Extract tower's new test primary projectile spawner as variable
    var test_tower_primary_projectile_spanwer: SingleMissileSpawner = SingleMissileSpawner.new()
    
    # Assign new projectile spawner to tower's singleton attribute
    test_tower.PRIMARY_PROJECTILE_SPAWNER = test_tower_primary_projectile_spanwer
    await get_tree().process_frame

    # Set arbitrary values to ensure test projectile spawner can be created
    test_tower_primary_projectile_spanwer.__detection_range = 50

    # Add tower's new test primary projectile spawner as its child
    test_tower.add_child(test_tower_primary_projectile_spanwer)
    await get_tree().process_frame

    # Ensure tower's primary projectile spanwer is the intended type
    assert_true(test_tower.PRIMARY_PROJECTILE_SPAWNER is SingleMissileSpawner, "Tower's primary projectile spawner is SingleMissileSpawner")

    # Set primary projectile spawner's starting damage
    test_tower_primary_projectile_spanwer.__missile_damage = STARTING_DAMAGE

    # Add tower to scene
    add_child_autofree(test_tower)
    await get_tree().process_frame # let _ready run & signals connect
    await get_tree().physics_frame # register shapes this tick

    # Ensure tower's detection area has been created
    assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

    # Ensure starting damage has been assigned as expected
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure projectile spawner's initial damage singleton has been properly assigned
    assert_eq(test_tower_primary_projectile_spanwer.INITIAL_DAMAGE, STARTING_DAMAGE)

    # Create damage aura
    var damage_aura: TowerDamageAura = TowerAuraConstants.TOWER_DAMAGE_AURA_PRELOAD.instantiate()
    damage_aura.DAMAGE_INCREASE_FACTOR = DAMAGE_INCREASE_FACTOR_VALUE

    # Add damage aura to scene
    add_child_autofree(damage_aura)
    await get_tree().process_frame # added to tree
    await get_tree().physics_frame # shapes registered
    await get_tree().physics_frame # overlaps resolved & signals emitted

    # Ensure damage aura and tower have the same global position, thus ensuring that
    # the damage aura will be able to enter the tower's detection area.
    assert_eq(damage_aura.global_position, test_tower.global_position, "Damage aura and tower have the same global positions")

    # Ensure projectile spawner's damage has been increased
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, EXPECTED_BUFFED_DAMAGE)

    # Ensure total damage buff amount gets updated 
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), EXPECTED_DAMAGE_BUFF_AMOUNT)

    # Ensure damage aura is being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.keys().has(damage_aura), "Aura manager is tracking damage aura")
    assert_eq(test_tower.TOWER_AURA_MANAGER.__active_damage_auras[damage_aura], EXPECTED_DAMAGE_BUFF_AMOUNT, "Damage buff amount is being correctly tracked")

    # Remove damage aura
    damage_aura.queue_free()
    await get_tree().process_frame # node is actually freed here
    await get_tree().physics_frame # broadphase updates; exit likely emitted
    await get_tree().physics_frame # ensure everything settles

    # Ensure damage aura is no longer being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.is_empty(), "Damage aura no longer being tracked by aura manager")

    # Ensure primary projectile spawner's damage has been reset to initial amount
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure bonus damage amount is no longer being displayed
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), 0, "Bonus damage no longer being displayed")

    # Clean up
    test_tower.queue_free()

func test_damage_aura_random_ricochet_missile_spanwer_buff():
    # TEST VALUES
    const STARTING_DAMAGE: int = 100
    const DAMAGE_INCREASE_FACTOR_VALUE: float = 0.2
    const EXPECTED_BUFFED_DAMAGE: int = 120
    const EXPECTED_DAMAGE_BUFF_AMOUNT: int = 20

    # Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
    # spawners or auras which might interfere with solely testing entry of a single damage aura. 
    var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

    # Replace tower's primary projectile spanwer with RandomRicochetMissileSpawner 
    test_tower.PRIMARY_PROJECTILE_SPAWNER.queue_free()

    # Extract tower's new test primary projectile spawner as variable
    var test_tower_primary_projectile_spanwer: RandomRicochetMissileSpawner = RandomRicochetMissileSpawner.new()
    
    # Assign new projectile spawner to tower's singleton attribute
    test_tower.PRIMARY_PROJECTILE_SPAWNER = test_tower_primary_projectile_spanwer
    await get_tree().process_frame

    # Set arbitrary values to ensure test projectile spawner can be created
    test_tower_primary_projectile_spanwer.__detection_range = 50

    # Add tower's new test primary projectile spawner as its child
    test_tower.add_child(test_tower_primary_projectile_spanwer)
    await get_tree().process_frame

    # Ensure tower's primary projectile spanwer is the intended type
    assert_true(test_tower.PRIMARY_PROJECTILE_SPAWNER is RandomRicochetMissileSpawner, "Tower's primary projectile spawner is RandomRicochetMissileSpawner")

    # Set primary projectile spawner's starting damage
    test_tower_primary_projectile_spanwer.__missile_damage = STARTING_DAMAGE

    # Add tower to scene
    add_child_autofree(test_tower)
    await get_tree().process_frame # let _ready run & signals connect
    await get_tree().physics_frame # register shapes this tick

    # Ensure tower's detection area has been created
    assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

    # Ensure starting damage has been assigned as expected
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure projectile spawner's initial damage singleton has been properly assigned
    assert_eq(test_tower_primary_projectile_spanwer.INITIAL_DAMAGE, STARTING_DAMAGE)

    # Create damage aura
    var damage_aura: TowerDamageAura = TowerAuraConstants.TOWER_DAMAGE_AURA_PRELOAD.instantiate()
    damage_aura.DAMAGE_INCREASE_FACTOR = DAMAGE_INCREASE_FACTOR_VALUE

    # Add damage aura to scene
    add_child_autofree(damage_aura)
    await get_tree().process_frame # added to tree
    await get_tree().physics_frame # shapes registered
    await get_tree().physics_frame # overlaps resolved & signals emitted

    # Ensure damage aura and tower have the same global position, thus ensuring that
    # the damage aura will be able to enter the tower's detection area.
    assert_eq(damage_aura.global_position, test_tower.global_position, "Damage aura and tower have the same global positions")

    # Ensure projectile spawner's damage has been increased
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, EXPECTED_BUFFED_DAMAGE)

    # Ensure total damage buff amount gets updated 
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), EXPECTED_DAMAGE_BUFF_AMOUNT)

    # Ensure damage aura is being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.keys().has(damage_aura), "Aura manager is tracking damage aura")
    assert_eq(test_tower.TOWER_AURA_MANAGER.__active_damage_auras[damage_aura], EXPECTED_DAMAGE_BUFF_AMOUNT, "Damage buff amount is being correctly tracked")

    # Remove damage aura
    damage_aura.queue_free()
    await get_tree().process_frame # node is actually freed here
    await get_tree().physics_frame # broadphase updates; exit likely emitted
    await get_tree().physics_frame # ensure everything settles

    # Ensure damage aura is no longer being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.is_empty(), "Damage aura no longer being tracked by aura manager")

    # Ensure primary projectile spawner's damage has been reset to initial amount
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure bonus damage amount is no longer being displayed
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), 0, "Bonus damage no longer being displayed")

    # Clean up
    test_tower.queue_free()

func test_damage_aura_tergeted_ricochet_missile_spanwer_buff():
    # TEST VALUES
    const STARTING_DAMAGE: int = 100
    const DAMAGE_INCREASE_FACTOR_VALUE: float = 0.2
    const EXPECTED_BUFFED_DAMAGE: int = 120
    const EXPECTED_DAMAGE_BUFF_AMOUNT: int = 20

    # Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
    # spawners or auras which might interfere with solely testing entry of a single damage aura. 
    var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

    # Replace tower's primary projectile spanwer with TargetedRicochetMissileSpawner 
    test_tower.PRIMARY_PROJECTILE_SPAWNER.queue_free()

    # Extract tower's new test primary projectile spawner as variable
    var test_tower_primary_projectile_spanwer: TargetedRicochetMissileSpawner = TargetedRicochetMissileSpawner.new()
    
    # Assign new projectile spawner to tower's singleton attribute
    test_tower.PRIMARY_PROJECTILE_SPAWNER = test_tower_primary_projectile_spanwer
    await get_tree().process_frame

    # Set arbitrary values to ensure test projectile spawner can be created
    test_tower_primary_projectile_spanwer.__detection_range = 50

    # Add tower's new test primary projectile spawner as its child
    test_tower.add_child(test_tower_primary_projectile_spanwer)
    await get_tree().process_frame

    # Ensure tower's primary projectile spanwer is the intended type
    assert_true(test_tower.PRIMARY_PROJECTILE_SPAWNER is TargetedRicochetMissileSpawner, "Tower's primary projectile spawner is TargetedRicochetMissileSpawner")

    # Set primary projectile spawner's starting damage
    test_tower_primary_projectile_spanwer.__missile_damage = STARTING_DAMAGE

    # Add tower to scene
    add_child_autofree(test_tower)
    await get_tree().process_frame # let _ready run & signals connect
    await get_tree().physics_frame # register shapes this tick

    # Ensure tower's detection area has been created
    assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

    # Ensure starting damage has been assigned as expected
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure projectile spawner's initial damage singleton has been properly assigned
    assert_eq(test_tower_primary_projectile_spanwer.INITIAL_DAMAGE, STARTING_DAMAGE)

    # Create damage aura
    var damage_aura: TowerDamageAura = TowerAuraConstants.TOWER_DAMAGE_AURA_PRELOAD.instantiate()
    damage_aura.DAMAGE_INCREASE_FACTOR = DAMAGE_INCREASE_FACTOR_VALUE

    # Add damage aura to scene
    add_child_autofree(damage_aura)
    await get_tree().process_frame # added to tree
    await get_tree().physics_frame # shapes registered
    await get_tree().physics_frame # overlaps resolved & signals emitted

    # Ensure damage aura and tower have the same global position, thus ensuring that
    # the damage aura will be able to enter the tower's detection area.
    assert_eq(damage_aura.global_position, test_tower.global_position, "Damage aura and tower have the same global positions")

    # Ensure projectile spawner's damage has been increased
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, EXPECTED_BUFFED_DAMAGE)

    # Ensure total damage buff amount gets updated 
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), EXPECTED_DAMAGE_BUFF_AMOUNT)

    # Ensure damage aura is being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.keys().has(damage_aura), "Aura manager is tracking damage aura")
    assert_eq(test_tower.TOWER_AURA_MANAGER.__active_damage_auras[damage_aura], EXPECTED_DAMAGE_BUFF_AMOUNT, "Damage buff amount is being correctly tracked")

    # Remove damage aura
    damage_aura.queue_free()
    await get_tree().process_frame # node is actually freed here
    await get_tree().physics_frame # broadphase updates; exit likely emitted
    await get_tree().physics_frame # ensure everything settles

    # Ensure damage aura is no longer being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.is_empty(), "Damage aura no longer being tracked by aura manager")

    # Ensure primary projectile spawner's damage has been reset to initial amount
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure bonus damage amount is no longer being displayed
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), 0, "Bonus damage no longer being displayed")

    # Clean up
    test_tower.queue_free()

func test_damage_aura_multi_random_ricochet_missile_spanwer_buff():
    # TEST VALUES
    const STARTING_DAMAGE: int = 100
    const DAMAGE_INCREASE_FACTOR_VALUE: float = 0.2
    const EXPECTED_BUFFED_DAMAGE: int = 120
    const EXPECTED_DAMAGE_BUFF_AMOUNT: int = 20

    # Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
    # spawners or auras which might interfere with solely testing entry of a single damage aura. 
    var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

    # Replace tower's primary projectile spanwer with MultiRandomRicochetMissileSpawner 
    test_tower.PRIMARY_PROJECTILE_SPAWNER.queue_free()

    # Extract tower's new test primary projectile spawner as variable
    var test_tower_primary_projectile_spanwer: MultiRandomRicochetMissileSpawner = MultiRandomRicochetMissileSpawner.new()
    
    # Assign new projectile spawner to tower's singleton attribute
    test_tower.PRIMARY_PROJECTILE_SPAWNER = test_tower_primary_projectile_spanwer
    await get_tree().process_frame

    # Set arbitrary values to ensure test projectile spawner can be created
    test_tower_primary_projectile_spanwer.__detection_range = 50

    # Add tower's new test primary projectile spawner as its child
    test_tower.add_child(test_tower_primary_projectile_spanwer)
    await get_tree().process_frame

    # Ensure tower's primary projectile spanwer is the intended type
    assert_true(test_tower.PRIMARY_PROJECTILE_SPAWNER is MultiRandomRicochetMissileSpawner, "Tower's primary projectile spawner is MultiRandomRicochetMissileSpawner")

    # Set primary projectile spawner's starting damage
    test_tower_primary_projectile_spanwer.__missile_damage = STARTING_DAMAGE

    # Add tower to scene
    add_child_autofree(test_tower)
    await get_tree().process_frame # let _ready run & signals connect
    await get_tree().physics_frame # register shapes this tick

    # Ensure tower's detection area has been created
    assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

    # Ensure starting damage has been assigned as expected
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure projectile spawner's initial damage singleton has been properly assigned
    assert_eq(test_tower_primary_projectile_spanwer.INITIAL_DAMAGE, STARTING_DAMAGE)

    # Create damage aura
    var damage_aura: TowerDamageAura = TowerAuraConstants.TOWER_DAMAGE_AURA_PRELOAD.instantiate()
    damage_aura.DAMAGE_INCREASE_FACTOR = DAMAGE_INCREASE_FACTOR_VALUE

    # Add damage aura to scene
    add_child_autofree(damage_aura)
    await get_tree().process_frame # added to tree
    await get_tree().physics_frame # shapes registered
    await get_tree().physics_frame # overlaps resolved & signals emitted

    # Ensure damage aura and tower have the same global position, thus ensuring that
    # the damage aura will be able to enter the tower's detection area.
    assert_eq(damage_aura.global_position, test_tower.global_position, "Damage aura and tower have the same global positions")

    # Ensure projectile spawner's damage has been increased
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, EXPECTED_BUFFED_DAMAGE)

    # Ensure total damage buff amount gets updated 
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), EXPECTED_DAMAGE_BUFF_AMOUNT)

    # Ensure damage aura is being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.keys().has(damage_aura), "Aura manager is tracking damage aura")
    assert_eq(test_tower.TOWER_AURA_MANAGER.__active_damage_auras[damage_aura], EXPECTED_DAMAGE_BUFF_AMOUNT, "Damage buff amount is being correctly tracked")

    # Remove damage aura
    damage_aura.queue_free()
    await get_tree().process_frame # node is actually freed here
    await get_tree().physics_frame # broadphase updates; exit likely emitted
    await get_tree().physics_frame # ensure everything settles

    # Ensure damage aura is no longer being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.is_empty(), "Damage aura no longer being tracked by aura manager")

    # Ensure primary projectile spawner's damage has been reset to initial amount
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure bonus damage amount is no longer being displayed
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), 0, "Bonus damage no longer being displayed")

    # Clean up
    test_tower.queue_free()

func test_damage_aura_star_random_ricochet_missile_spanwer_buff():
    # TEST VALUES
    const STARTING_DAMAGE: int = 100
    const DAMAGE_INCREASE_FACTOR_VALUE: float = 0.2
    const EXPECTED_BUFFED_DAMAGE: int = 120
    const EXPECTED_DAMAGE_BUFF_AMOUNT: int = 20

    # Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
    # spawners or auras which might interfere with solely testing entry of a single damage aura. 
    var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

    # Replace tower's primary projectile spanwer with StarRandomRicochetMissileSpawner 
    test_tower.PRIMARY_PROJECTILE_SPAWNER.queue_free()

    # Extract tower's new test primary projectile spawner as variable
    var test_tower_primary_projectile_spanwer: StarRandomRicochetMissileSpawner = StarRandomRicochetMissileSpawner.new()
    
    # Assign new projectile spawner to tower's singleton attribute
    test_tower.PRIMARY_PROJECTILE_SPAWNER = test_tower_primary_projectile_spanwer
    await get_tree().process_frame

    # Set arbitrary values to ensure test projectile spawner can be created
    test_tower_primary_projectile_spanwer.__detection_range = 50

    # Add tower's new test primary projectile spawner as its child
    test_tower.add_child(test_tower_primary_projectile_spanwer)
    await get_tree().process_frame

    # Ensure tower's primary projectile spanwer is the intended type
    assert_true(test_tower.PRIMARY_PROJECTILE_SPAWNER is StarRandomRicochetMissileSpawner, "Tower's primary projectile spawner is StarRandomRicochetMissileSpawner")

    # Set primary projectile spawner's starting damage
    test_tower_primary_projectile_spanwer.__missile_damage = STARTING_DAMAGE

    # Add tower to scene
    add_child_autofree(test_tower)
    await get_tree().process_frame # let _ready run & signals connect
    await get_tree().physics_frame # register shapes this tick

    # Ensure tower's detection area has been created
    assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

    # Ensure starting damage has been assigned as expected
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure projectile spawner's initial damage singleton has been properly assigned
    assert_eq(test_tower_primary_projectile_spanwer.INITIAL_DAMAGE, STARTING_DAMAGE)

    # Create damage aura
    var damage_aura: TowerDamageAura = TowerAuraConstants.TOWER_DAMAGE_AURA_PRELOAD.instantiate()
    damage_aura.DAMAGE_INCREASE_FACTOR = DAMAGE_INCREASE_FACTOR_VALUE

    # Add damage aura to scene
    add_child_autofree(damage_aura)
    await get_tree().process_frame # added to tree
    await get_tree().physics_frame # shapes registered
    await get_tree().physics_frame # overlaps resolved & signals emitted

    # Ensure damage aura and tower have the same global position, thus ensuring that
    # the damage aura will be able to enter the tower's detection area.
    assert_eq(damage_aura.global_position, test_tower.global_position, "Damage aura and tower have the same global positions")

    # Ensure projectile spawner's damage has been increased
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, EXPECTED_BUFFED_DAMAGE)

    # Ensure total damage buff amount gets updated 
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), EXPECTED_DAMAGE_BUFF_AMOUNT)

    # Ensure damage aura is being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.keys().has(damage_aura), "Aura manager is tracking damage aura")
    assert_eq(test_tower.TOWER_AURA_MANAGER.__active_damage_auras[damage_aura], EXPECTED_DAMAGE_BUFF_AMOUNT, "Damage buff amount is being correctly tracked")

    # Remove damage aura
    damage_aura.queue_free()
    await get_tree().process_frame # node is actually freed here
    await get_tree().physics_frame # broadphase updates; exit likely emitted
    await get_tree().physics_frame # ensure everything settles

    # Ensure damage aura is no longer being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.is_empty(), "Damage aura no longer being tracked by aura manager")

    # Ensure primary projectile spawner's damage has been reset to initial amount
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure bonus damage amount is no longer being displayed
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), 0, "Bonus damage no longer being displayed")

    # Clean up
    test_tower.queue_free()

func test_damage_aura_multi_target_targeted_missile_spanwer_buff():
    # TEST VALUES
    const STARTING_DAMAGE: int = 100
    const DAMAGE_INCREASE_FACTOR_VALUE: float = 0.2
    const EXPECTED_BUFFED_DAMAGE: int = 120
    const EXPECTED_DAMAGE_BUFF_AMOUNT: int = 20

    # Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
    # spawners or auras which might interfere with solely testing entry of a single damage aura. 
    var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

    # Replace tower's primary projectile spanwer with MultiTargetTargetedRicochetMissileSpawner 
    test_tower.PRIMARY_PROJECTILE_SPAWNER.queue_free()

    # Extract tower's new test primary projectile spawner as variable
    var test_tower_primary_projectile_spanwer: MultiTargetTargetedRicochetMissileSpawner = MultiTargetTargetedRicochetMissileSpawner.new()
    
    # Assign new projectile spawner to tower's singleton attribute
    test_tower.PRIMARY_PROJECTILE_SPAWNER = test_tower_primary_projectile_spanwer
    await get_tree().process_frame

    # Set arbitrary values to ensure test projectile spawner can be created
    test_tower_primary_projectile_spanwer.__detection_range = 50

    # Add tower's new test primary projectile spawner as its child
    test_tower.add_child(test_tower_primary_projectile_spanwer)
    await get_tree().process_frame

    # Ensure tower's primary projectile spanwer is the intended type
    assert_true(test_tower.PRIMARY_PROJECTILE_SPAWNER is MultiTargetTargetedRicochetMissileSpawner, "Tower's primary projectile spawner is MultiTargetTargetedRicochetMissileSpawner")

    # Set primary projectile spawner's starting damage
    test_tower_primary_projectile_spanwer.__missile_damage = STARTING_DAMAGE

    # Add tower to scene
    add_child_autofree(test_tower)
    await get_tree().process_frame # let _ready run & signals connect
    await get_tree().physics_frame # register shapes this tick

    # Ensure tower's detection area has been created
    assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

    # Ensure starting damage has been assigned as expected
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure projectile spawner's initial damage singleton has been properly assigned
    assert_eq(test_tower_primary_projectile_spanwer.INITIAL_DAMAGE, STARTING_DAMAGE)

    # Create damage aura
    var damage_aura: TowerDamageAura = TowerAuraConstants.TOWER_DAMAGE_AURA_PRELOAD.instantiate()
    damage_aura.DAMAGE_INCREASE_FACTOR = DAMAGE_INCREASE_FACTOR_VALUE

    # Add damage aura to scene
    add_child_autofree(damage_aura)
    await get_tree().process_frame # added to tree
    await get_tree().physics_frame # shapes registered
    await get_tree().physics_frame # overlaps resolved & signals emitted

    # Ensure damage aura and tower have the same global position, thus ensuring that
    # the damage aura will be able to enter the tower's detection area.
    assert_eq(damage_aura.global_position, test_tower.global_position, "Damage aura and tower have the same global positions")

    # Ensure projectile spawner's damage has been increased
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, EXPECTED_BUFFED_DAMAGE)

    # Ensure total damage buff amount gets updated 
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), EXPECTED_DAMAGE_BUFF_AMOUNT)

    # Ensure damage aura is being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.keys().has(damage_aura), "Aura manager is tracking damage aura")
    assert_eq(test_tower.TOWER_AURA_MANAGER.__active_damage_auras[damage_aura], EXPECTED_DAMAGE_BUFF_AMOUNT, "Damage buff amount is being correctly tracked")

    # Remove damage aura
    damage_aura.queue_free()
    await get_tree().process_frame # node is actually freed here
    await get_tree().physics_frame # broadphase updates; exit likely emitted
    await get_tree().physics_frame # ensure everything settles

    # Ensure damage aura is no longer being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.is_empty(), "Damage aura no longer being tracked by aura manager")

    # Ensure primary projectile spawner's damage has been reset to initial amount
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure bonus damage amount is no longer being displayed
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), 0, "Bonus damage no longer being displayed")

    # Clean up
    test_tower.queue_free()


func test_damage_aura_targeted_multi_missile_spanwer_buff():
    # TEST VALUES
    const STARTING_DAMAGE: int = 100
    const DAMAGE_INCREASE_FACTOR_VALUE: float = 0.2
    const EXPECTED_BUFFED_DAMAGE: int = 120
    const EXPECTED_DAMAGE_BUFF_AMOUNT: int = 20

    # Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
    # spawners or auras which might interfere with solely testing entry of a single damage aura. 
    var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

    # Replace tower's primary projectile spanwer with TargetedMultiMissileSpawner 
    test_tower.PRIMARY_PROJECTILE_SPAWNER.queue_free()

    # Extract tower's new test primary projectile spawner as variable
    var test_tower_primary_projectile_spanwer: TargetedMultiMissileSpawner = TargetedMultiMissileSpawner.new()
    
    # Assign new projectile spawner to tower's singleton attribute
    test_tower.PRIMARY_PROJECTILE_SPAWNER = test_tower_primary_projectile_spanwer
    await get_tree().process_frame

    # Set arbitrary values to ensure test projectile spawner can be created
    test_tower_primary_projectile_spanwer.__detection_range = 50

    # Add tower's new test primary projectile spawner as its child
    test_tower.add_child(test_tower_primary_projectile_spanwer)
    await get_tree().process_frame

    # Ensure tower's primary projectile spanwer is the intended type
    assert_true(test_tower.PRIMARY_PROJECTILE_SPAWNER is TargetedMultiMissileSpawner, "Tower's primary projectile spawner is TargetedMultiMissileSpawner")

    # Set primary projectile spawner's starting damage
    test_tower_primary_projectile_spanwer.__missile_damage = STARTING_DAMAGE

    # Add tower to scene
    add_child_autofree(test_tower)
    await get_tree().process_frame # let _ready run & signals connect
    await get_tree().physics_frame # register shapes this tick

    # Ensure tower's detection area has been created
    assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

    # Ensure starting damage has been assigned as expected
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure projectile spawner's initial damage singleton has been properly assigned
    assert_eq(test_tower_primary_projectile_spanwer.INITIAL_DAMAGE, STARTING_DAMAGE)

    # Create damage aura
    var damage_aura: TowerDamageAura = TowerAuraConstants.TOWER_DAMAGE_AURA_PRELOAD.instantiate()
    damage_aura.DAMAGE_INCREASE_FACTOR = DAMAGE_INCREASE_FACTOR_VALUE

    # Add damage aura to scene
    add_child_autofree(damage_aura)
    await get_tree().process_frame # added to tree
    await get_tree().physics_frame # shapes registered
    await get_tree().physics_frame # overlaps resolved & signals emitted

    # Ensure damage aura and tower have the same global position, thus ensuring that
    # the damage aura will be able to enter the tower's detection area.
    assert_eq(damage_aura.global_position, test_tower.global_position, "Damage aura and tower have the same global positions")

    # Ensure projectile spawner's damage has been increased
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, EXPECTED_BUFFED_DAMAGE)

    # Ensure total damage buff amount gets updated 
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), EXPECTED_DAMAGE_BUFF_AMOUNT)

    # Ensure damage aura is being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.keys().has(damage_aura), "Aura manager is tracking damage aura")
    assert_eq(test_tower.TOWER_AURA_MANAGER.__active_damage_auras[damage_aura], EXPECTED_DAMAGE_BUFF_AMOUNT, "Damage buff amount is being correctly tracked")

    # Remove damage aura
    damage_aura.queue_free()
    await get_tree().process_frame # node is actually freed here
    await get_tree().physics_frame # broadphase updates; exit likely emitted
    await get_tree().physics_frame # ensure everything settles

    # Ensure damage aura is no longer being tracked by tower's aura manager
    assert_true(test_tower.TOWER_AURA_MANAGER.__active_damage_auras.is_empty(), "Damage aura no longer being tracked by aura manager")

    # Ensure primary projectile spawner's damage has been reset to initial amount
    assert_eq(test_tower_primary_projectile_spanwer.__missile_damage, STARTING_DAMAGE)

    # Ensure bonus damage amount is no longer being displayed
    assert_eq(test_tower_primary_projectile_spanwer.total_bonus_damage(), 0, "Bonus damage no longer being displayed")

    # Clean up
    test_tower.queue_free()