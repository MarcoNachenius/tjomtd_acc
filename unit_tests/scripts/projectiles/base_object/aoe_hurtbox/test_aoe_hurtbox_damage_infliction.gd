extends GutTest

# ===========
# DESCRIPTION
# ===========
#   This test suite is designed to verify the functionality of the AOE (Area of Effect) damage infliction system in projectiles.
#   The AOE hurtbox creation and damage infliction methods are defined in the Projectile base object, BUT the handling of 
#   the AOE damage infliction is defined in the inflict_damange() method of every Projectile subclass.
#   Therefore, this test suite is designed to test the AOE damage infliction system in the context of every Projectile subclass.
#
# ===================
# COVERED PROJECTILES
# ===================
#   - SingleHitBullet
#   - RandomRicochetBullet
#   - TargetedRicochetBullet
#   - TargetedRicochetMissile
#   - SingleHitMissile



func before_each():
    await get_tree().process_frame

func test_aoe_hurtbox_instantiation():
    # Reusable projectile values
    var projectile_global_position: Vector2 = Vector2(300, 300)
    var projectile_aoe_damage: int = 10
    var projectile_aoe_radius: int = 20
    var projectile_base_damage: int = 1
    
    # CREATE TEST PROJECTILE
    var test_projectile: SingleHitBullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1].instantiate()
    # Set base damage
    test_projectile.set_damage(projectile_base_damage)
    # Ensure projectile is not moving during testing
    test_projectile.set_speed(0)
    # Set up AOE damage values
    test_projectile.__aoe_enabled = true
    test_projectile.__aoe_damage_amount = projectile_aoe_damage
    test_projectile.__aoe_detection_radius = projectile_aoe_radius
    # Ensure creep in range signal triggering does not occur 
    test_projectile.global_position = projectile_global_position
    # Ensure projectile is properly added to scene
    add_child_autofree(test_projectile)
    await get_tree().process_frame

    # Assert AOE hurtbox has been created
    assert_not_null(test_projectile.__aoe_damage_hurtbox, "AOE hurtbox should be created")
    
    # Assert AOE hurtbox is in the correct position
    assert_eq(test_projectile.__aoe_damage_hurtbox.global_position, projectile_global_position, "AOE hurtbox should be in the same position as the projectile")

    # Assert AOE hurtbox has the correct radius
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_base_radius(), float(projectile_aoe_radius), "AOE hurtbox should have the same radius as the projectile")

    # Clean up
    test_projectile.queue_free()

func test_single_hit_bullet_aoe_damage_infliction():
    # Reusable projectile values
    var projectile_global_position: Vector2 = Vector2(300, 300)
    var projectile_aoe_damage: int = 10
    var projectile_aoe_radius: int = 20
    var projectile_base_damage: int = 1

    # Reusable creep test values
    var dummy_creep_health: int = 100
    var dummy_creep_global_position: Vector2 = Vector2(100, 100)
    
    # CREATE TEST PROJECTILE
    var test_projectile: SingleHitBullet = ProjectileConstants.SINGLE_HIT_BULLET_LOADS[ProjectileConstants.SingleHitBullets.BLACK_MARBLE_LVL_1].instantiate()
    # Set base damage
    test_projectile.set_damage(projectile_base_damage)
    # Ensure projectile is not moving during testing
    test_projectile.set_speed(0)
    # Set up AOE damage values
    test_projectile.__aoe_enabled = true
    test_projectile.__aoe_damage_amount = projectile_aoe_damage
    test_projectile.__aoe_detection_radius = projectile_aoe_radius
    # Ensure creep in range signal triggering does not occur 
    test_projectile.global_position = projectile_global_position
    # Ensure projectile is properly added to scene
    add_child_autofree(test_projectile)
    await get_tree().process_frame


    # CREATE TEST DUMMIES
    var dummy_creep_1: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_1)
    # Ensure creep does handle movement during testing
    dummy_creep_1.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_1.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_1.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_2: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_2)
    # Ensure creep does handle movement during testing
    dummy_creep_2.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_2.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_2.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_3: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_3)
    # Ensure creep does handle movement during testing
    dummy_creep_3.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_3.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_3.global_position = dummy_creep_global_position
    await get_tree().process_frame

    # Ensure that creeps and projectile were placed far enough apart from each other
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 0, "Creep should not be in range of AOE hurtbox")
    
    # Simulate dummies entering the AOE hurtbox
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_1.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_2.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_3.__hitbox)
    await get_tree().process_frame

    # Assert that the AOE hurtbox has detected the dummies
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 3, "AOE hurtbox should detect 3 creeps")

    # Simulate the projectile inflicting damage to dummy creep 2
    test_projectile._inflict_damange(dummy_creep_2)
    await get_tree().process_frame

    # Create expected damage values
    var expected_creep_1_health: int = dummy_creep_health - projectile_aoe_damage
    var expected_creep_2_health: int = dummy_creep_health - projectile_aoe_damage - projectile_base_damage
    var expected_creep_3_health: int = dummy_creep_health - projectile_aoe_damage

    # Assert that the dummies have taken the correct amount of damage
    assert_eq(dummy_creep_1.get_curr_health(), expected_creep_1_health, "Dummy creep 1 should have taken AOE damage")
    assert_eq(dummy_creep_2.get_curr_health(), expected_creep_2_health, "Dummy creep 2 should have taken AOE damage and projectile base damage")
    assert_eq(dummy_creep_3.get_curr_health(), expected_creep_3_health, "Dummy creep 3 should have taken AOE damage")

    # Clean up
    # Projectile queue free not needed because it get freed when it inflicts damage
    dummy_creep_1.queue_free()
    dummy_creep_2.queue_free()
    dummy_creep_3.queue_free()

func test_random_ricochet_bullet_aoe_damage_infliction():
    # Reusable projectile values
    var projectile_global_position: Vector2 = Vector2(300, 300)
    var projectile_aoe_damage: int = 10
    var projectile_aoe_radius: int = 20
    var projectile_base_damage: int = 1

    # Reusable creep test values
    var dummy_creep_health: int = 100
    var dummy_creep_global_position: Vector2 = Vector2(100, 100)
    
    # CREATE TEST PROJECTILE
    var test_projectile: RandomRicochetBullet = ProjectileConstants.RANDOM_RICOCHET_BULLET_LOADS[ProjectileConstants.RandomRicochetBullets.BLACK_MARBLE_LVL_2].instantiate()
    # Set base damage
    test_projectile.set_damage(projectile_base_damage)
    # Ensure projectile is not moving during testing
    test_projectile.set_speed(1)
    # Ensure projectile does not have empty velocity
    test_projectile.__velocity = Vector2(1, 0)
    # Set up AOE damage values
    test_projectile.__aoe_enabled = true
    test_projectile.__aoe_damage_amount = projectile_aoe_damage
    test_projectile.__aoe_detection_radius = projectile_aoe_radius
    # Ensure creep in range signal triggering does not occur 
    test_projectile.global_position = projectile_global_position
    # Ensure projectile is properly added to scene
    add_child_autofree(test_projectile)
    await get_tree().process_frame


    # CREATE TEST DUMMIES
    var dummy_creep_1: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_1)
    # Ensure creep does handle movement during testing
    dummy_creep_1.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_1.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_1.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_2: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_2)
    # Ensure creep does handle movement during testing
    dummy_creep_2.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_2.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_2.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_3: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_3)
    # Ensure creep does handle movement during testing
    dummy_creep_3.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_3.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_3.global_position = dummy_creep_global_position
    await get_tree().process_frame

    # Ensure that creeps and projectile were placed far enough apart from each other
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 0, "Creep should not be in range of AOE hurtbox")
    
    # Simulate dummies entering the AOE hurtbox
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_1.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_2.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_3.__hitbox)
    await get_tree().process_frame

    # Assert that the AOE hurtbox has detected the dummies
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 3, "AOE hurtbox should detect 3 creeps")

    # Simulate the projectile inflicting damage to dummy creep 2
    test_projectile._inflict_damange(dummy_creep_2)
    await get_tree().process_frame

    # Create expected damage values
    var expected_creep_1_health: int = dummy_creep_health - projectile_aoe_damage
    var expected_creep_2_health: int = dummy_creep_health - projectile_aoe_damage - projectile_base_damage
    var expected_creep_3_health: int = dummy_creep_health - projectile_aoe_damage

    # Assert that the dummies have taken the correct amount of damage
    assert_eq(dummy_creep_1.get_curr_health(), expected_creep_1_health, "Dummy creep 1 should have taken AOE damage")
    assert_eq(dummy_creep_2.get_curr_health(), expected_creep_2_health, "Dummy creep 2 should have taken AOE damage and projectile base damage")
    assert_eq(dummy_creep_3.get_curr_health(), expected_creep_3_health, "Dummy creep 3 should have taken AOE damage")

    # Clean up
    # Projectile queue free not needed because it get freed when it inflicts damage
    dummy_creep_1.queue_free()
    dummy_creep_2.queue_free()
    dummy_creep_3.queue_free()

func test_targeted_ricochet_bullet_aoe_damage_infliction():
    # Reusable projectile values
    var projectile_global_position: Vector2 = Vector2(300, 300)
    var projectile_aoe_damage: int = 10
    var projectile_aoe_radius: int = 20
    var projectile_base_damage: int = 1

    # Reusable creep test values
    var dummy_creep_health: int = 100
    var dummy_creep_global_position: Vector2 = Vector2(100, 100)
    
    # CREATE TEST PROJECTILE
    var test_projectile: TargetedRicochetBullet = ProjectileConstants.TARGETED_RICOCHET_BULLET_LOADS[ProjectileConstants.TargetedRicochetBullets.BLACK_MARBLE_LVL_3].instantiate()
    # Set base damage
    test_projectile.set_damage(projectile_base_damage)
    # Ensure projectile is not moving during testing
    test_projectile.set_speed(1)
    # Ensure projectile does not have empty velocity
    test_projectile.__velocity = Vector2(1, 0)
    # Set up AOE damage values
    test_projectile.__aoe_enabled = true
    test_projectile.__aoe_damage_amount = projectile_aoe_damage
    test_projectile.__aoe_detection_radius = projectile_aoe_radius
    # Ensure creep in range signal triggering does not occur 
    test_projectile.global_position = projectile_global_position
    # Ensure projectile is properly added to scene
    add_child_autofree(test_projectile)
    await get_tree().process_frame


    # CREATE TEST DUMMIES
    var dummy_creep_1: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_1)
    # Ensure creep does handle movement during testing
    dummy_creep_1.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_1.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_1.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_2: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_2)
    # Ensure creep does handle movement during testing
    dummy_creep_2.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_2.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_2.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_3: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_3)
    # Ensure creep does handle movement during testing
    dummy_creep_3.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_3.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_3.global_position = dummy_creep_global_position
    await get_tree().process_frame

    # Ensure that creeps and projectile were placed far enough apart from each other
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 0, "Creep should not be in range of AOE hurtbox")
    
    # Simulate dummies entering the AOE hurtbox
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_1.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_2.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_3.__hitbox)
    await get_tree().process_frame

    # Assert that the AOE hurtbox has detected the dummies
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 3, "AOE hurtbox should detect 3 creeps")

    # Simulate the projectile inflicting damage to dummy creep 2
    test_projectile._inflict_damange(dummy_creep_2)
    await get_tree().process_frame

    # Create expected damage values
    var expected_creep_1_health: int = dummy_creep_health - projectile_aoe_damage
    var expected_creep_2_health: int = dummy_creep_health - projectile_aoe_damage - projectile_base_damage
    var expected_creep_3_health: int = dummy_creep_health - projectile_aoe_damage

    # Assert that the dummies have taken the correct amount of damage
    assert_eq(dummy_creep_1.get_curr_health(), expected_creep_1_health, "Dummy creep 1 should have taken AOE damage")
    assert_eq(dummy_creep_2.get_curr_health(), expected_creep_2_health, "Dummy creep 2 should have taken AOE damage and projectile base damage")
    assert_eq(dummy_creep_3.get_curr_health(), expected_creep_3_health, "Dummy creep 3 should have taken AOE damage")

    # Clean up
    # Projectile queue free not needed because it get freed when it inflicts damage
    dummy_creep_1.queue_free()
    dummy_creep_2.queue_free()
    dummy_creep_3.queue_free()


func test_targeted_ricochet_missile_aoe_damage_infliction():
    # Reusable projectile values
    var projectile_global_position: Vector2 = Vector2(300, 300)
    var projectile_aoe_damage: int = 10
    var projectile_aoe_radius: int = 20
    var projectile_base_damage: int = 1

    # Reusable creep test values
    var dummy_creep_health: int = 100
    var dummy_creep_global_position: Vector2 = Vector2(100, 100)
    
    # CREATE TEST PROJECTILE
    var test_projectile: TargetedRicochetMissile = ProjectileConstants.TARGETED_RICOCHET_MISSILE_LOADS[ProjectileConstants.TargetedRicochetMissiles.TEST_TARGETED_RICOCHET_MISSILE].instantiate()
    # Set base damage
    test_projectile.set_damage(projectile_base_damage)
    # Ensure projectile is not moving during testing
    test_projectile.set_speed(1)
    # Ensure projectile does not have empty velocity
    test_projectile.__velocity = Vector2(1, 0)
    # Set up AOE damage values
    test_projectile.__aoe_enabled = true
    test_projectile.__aoe_damage_amount = projectile_aoe_damage
    test_projectile.__aoe_detection_radius = projectile_aoe_radius
    # Ensure creep in range signal triggering does not occur 
    test_projectile.global_position = projectile_global_position
    # Ensure projectile is properly added to scene
    add_child_autofree(test_projectile)
    await get_tree().process_frame


    # CREATE TEST DUMMIES
    var dummy_creep_1: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_1)
    # Ensure creep does handle movement during testing
    dummy_creep_1.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_1.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_1.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_2: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_2)
    # Ensure creep does handle movement during testing
    dummy_creep_2.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_2.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_2.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_3: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_3)
    # Ensure creep does handle movement during testing
    dummy_creep_3.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_3.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_3.global_position = dummy_creep_global_position
    await get_tree().process_frame

    # Ensure that creeps and projectile were placed far enough apart from each other
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 0, "Creep should not be in range of AOE hurtbox")
    
    # Simulate dummies entering the AOE hurtbox
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_1.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_2.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_3.__hitbox)
    await get_tree().process_frame

    # Assert that the AOE hurtbox has detected the dummies
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 3, "AOE hurtbox should detect 3 creeps")

    # Simulate the projectile inflicting damage to dummy creep 2
    test_projectile._inflict_damange(dummy_creep_2)
    await get_tree().process_frame

    # Create expected damage values
    var expected_creep_1_health: int = dummy_creep_health - projectile_aoe_damage
    var expected_creep_2_health: int = dummy_creep_health - projectile_aoe_damage - projectile_base_damage
    var expected_creep_3_health: int = dummy_creep_health - projectile_aoe_damage

    # Assert that the dummies have taken the correct amount of damage
    assert_eq(dummy_creep_1.get_curr_health(), expected_creep_1_health, "Dummy creep 1 should have taken AOE damage")
    assert_eq(dummy_creep_2.get_curr_health(), expected_creep_2_health, "Dummy creep 2 should have taken AOE damage and projectile base damage")
    assert_eq(dummy_creep_3.get_curr_health(), expected_creep_3_health, "Dummy creep 3 should have taken AOE damage")

    # Clean up
    # Projectile queue free not needed because it get freed when it inflicts damage
    dummy_creep_1.queue_free()
    dummy_creep_2.queue_free()
    dummy_creep_3.queue_free()

func test_single_hit_missile_aoe_damage_infliction():
    # Reusable projectile values
    var projectile_global_position: Vector2 = Vector2(300, 300)
    var projectile_aoe_damage: int = 10
    var projectile_aoe_radius: int = 20
    var projectile_base_damage: int = 1

    # Reusable creep test values
    var dummy_creep_health: int = 100
    var dummy_creep_global_position: Vector2 = Vector2(100, 100)
    
    # CREATE TEST PROJECTILE
    var test_projectile: SingleHitMissile = ProjectileConstants.SINGLE_HIT_MISSILE_LOADS[ProjectileConstants.SingleHitMissiles.BISMUTH_LVL_1].instantiate()
    # Set base damage
    test_projectile.set_damage(projectile_base_damage)
    # Ensure projectile is not moving during testing
    test_projectile.set_speed(1)
    # Ensure projectile does not have empty velocity
    test_projectile.__velocity = Vector2(1, 0)
    # Set up AOE damage values
    test_projectile.__aoe_enabled = true
    test_projectile.__aoe_damage_amount = projectile_aoe_damage
    test_projectile.__aoe_detection_radius = projectile_aoe_radius
    # Ensure creep in range signal triggering does not occur 
    test_projectile.global_position = projectile_global_position
    # Ensure projectile is properly added to scene
    add_child_autofree(test_projectile)
    await get_tree().process_frame


    # CREATE TEST DUMMIES
    var dummy_creep_1: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_1)
    # Ensure creep does handle movement during testing
    dummy_creep_1.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_1.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_1.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_2: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_2)
    # Ensure creep does handle movement during testing
    dummy_creep_2.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_2.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_2.global_position = dummy_creep_global_position
    await get_tree().process_frame

    var dummy_creep_3: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep_3)
    # Ensure creep does handle movement during testing
    dummy_creep_3.stun(10.0)
    # Ensure creep does not die from test hit
    dummy_creep_3.set_curr_health(dummy_creep_health)
    # Ensure creep in range signal triggering does not occur  
    dummy_creep_3.global_position = dummy_creep_global_position
    await get_tree().process_frame

    # Ensure that creeps and projectile were placed far enough apart from each other
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 0, "Creep should not be in range of AOE hurtbox")
    
    # Simulate dummies entering the AOE hurtbox
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_1.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_2.__hitbox)
    test_projectile.__aoe_damage_hurtbox._on_area_entered(dummy_creep_3.__hitbox)
    await get_tree().process_frame

    # Assert that the AOE hurtbox has detected the dummies
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 3, "AOE hurtbox should detect 3 creeps")

    # Simulate the projectile inflicting damage to dummy creep 2
    test_projectile._inflict_damange(dummy_creep_2)
    await get_tree().process_frame

    # Create expected damage values
    var expected_creep_1_health: int = dummy_creep_health - projectile_aoe_damage
    var expected_creep_2_health: int = dummy_creep_health - projectile_aoe_damage - projectile_base_damage
    var expected_creep_3_health: int = dummy_creep_health - projectile_aoe_damage

    # Assert that the dummies have taken the correct amount of damage
    assert_eq(dummy_creep_1.get_curr_health(), expected_creep_1_health, "Dummy creep 1 should have taken AOE damage")
    assert_eq(dummy_creep_2.get_curr_health(), expected_creep_2_health, "Dummy creep 2 should have taken AOE damage and projectile base damage")
    assert_eq(dummy_creep_3.get_curr_health(), expected_creep_3_health, "Dummy creep 3 should have taken AOE damage")

    # Clean up
    # Projectile queue free not needed because it get freed when it inflicts damage
    dummy_creep_1.queue_free()
    dummy_creep_2.queue_free()
    dummy_creep_3.queue_free()

    