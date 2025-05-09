extends GutTest

## DESCRIPTION:
# This test suite is designed to verify the functionality of the AOE (Area of Effect) damage infliction system in projectiles.
# The AOE hurtbox creation and damage infliction methods are defined in the Projectile base object, BUT the handling of 
# the AOE damage infliction is defined in the inflict_damange() method of every Projectile subclass.
# Therefore, this test suite is designed to test the AOE damage infliction system in the context of every Projectile subclass.

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

func test_shb_aoe_damage_infliction():
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

    # Ensure that creeps and projectile were placed far enough apart from each other
    assert_eq(test_projectile.__aoe_damage_hurtbox.get_detectable_creeps_in_range().size(), 0, "Creep should not be in range of AOE hurtbox")
    


    # Clean up
    test_projectile.queue_free()
    dummy_creep_1.queue_free()