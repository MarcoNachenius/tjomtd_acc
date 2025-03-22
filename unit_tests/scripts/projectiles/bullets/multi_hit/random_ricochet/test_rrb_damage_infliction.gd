extends GutTest

## Reset before each test case
func before_each():
    await get_tree().process_frame  # Ensure previous nodes are fully freed.

func test_inflict_damage_method():
    # Create test creep
    var test_creep: Creep = CreepConstants.CreepPreloads[0].instantiate()
    test_creep.set_curr_health(100)

    # Create test bullet
    var test_bullet := RandomRicochetBullet.new()
    test_bullet.set_damage(10)

    # Add test objects to the scene
    add_child_autofree(test_creep)
    add_child_autofree(test_bullet)

    # Verify that the test creep has full health
    assert_eq(test_creep.get_curr_health(), 100)

    # Inflict damage on test creep
    test_bullet._inflict_damange(test_creep)

    # Verify that the test creep has taken the expedted amount of damage
    assert_eq(test_creep.get_curr_health(), 90)

    # Clean up
    test_creep.queue_free()
    test_bullet.queue_free()

func test_damage_infliction_without_damage_degradation():
    # Create test creeps
    var first_test_creep: Creep = CreepConstants.CreepPreloads[0].instantiate()
    first_test_creep.set_curr_health(100)
    var second_test_creep: Creep = CreepConstants.CreepPreloads[0].instantiate()
    second_test_creep.set_curr_health(100)

    # Create test bullet
    var test_bullet := RandomRicochetBullet.new()
    # Enable infinite ricochets so that it does not get destroyed because of ricochet limit
    test_bullet.__infinite_ricochets = true
    test_bullet.set_damage(10)

    # Add test objects to the scene
    add_child_autofree(first_test_creep)
    add_child_autofree(second_test_creep)
    add_child_autofree(test_bullet)

    # Verify initial creep health and bullet damage
    assert_eq(first_test_creep.get_curr_health(), 100)
    assert_eq(second_test_creep.get_curr_health(), 100)
    assert_eq(test_bullet.__damage, 10)
    assert_eq(first_test_creep.get_curr_health(), 100)

    # Inflict damage on the first test creep
    test_bullet._inflict_damange(first_test_creep)

    # Verify that the first test creep has taken the expedted amount of damage
    assert_eq(first_test_creep.get_curr_health(), 90)
    # Verify that the bullet has not degraded in damage
    assert_eq(test_bullet.__damage, 10)

    # Inflict damage on the second test creep
    test_bullet._inflict_damange(second_test_creep)

    # Verify that the second test creep has taken the expedted amount of damage
    assert_eq(second_test_creep.get_curr_health(), 90)
    # Verify that the bullet has not degraded in damage
    assert_eq(test_bullet.__damage, 10)

    # Clean up
    first_test_creep.queue_free()
    second_test_creep.queue_free()
    test_bullet.queue_free()


func test_damage_infliction_with_damage_degradation():
    # Create test creeps
    var first_test_creep: Creep = CreepConstants.CreepPreloads[0].instantiate()
    first_test_creep.set_curr_health(100)
    var second_test_creep: Creep = CreepConstants.CreepPreloads[0].instantiate()
    second_test_creep.set_curr_health(100)

    # Create test bullet
    var test_bullet := RandomRicochetBullet.new()
    # Enable infinite ricochets so that it does not get destroyed because of ricochet limit
    test_bullet.__infinite_ricochets = true
    test_bullet.set_damage(10)
    # Enable damage degradation
    test_bullet.__damage_degredation_enabled = true
    test_bullet.__damage_degredation_rate = 2

    # Add test objects to the scene
    add_child_autofree(first_test_creep)
    add_child_autofree(second_test_creep)
    add_child_autofree(test_bullet)

    # Verify initial creep health and bullet damage
    assert_eq(first_test_creep.get_curr_health(), 100)
    assert_eq(second_test_creep.get_curr_health(), 100)
    assert_eq(test_bullet.__damage, 10)
    assert_eq(first_test_creep.get_curr_health(), 100)

    # Inflict damage on the first test creep
    test_bullet._inflict_damange(first_test_creep)

    # Verify that the first test creep has taken the expedted amount of damage
    assert_eq(first_test_creep.get_curr_health(), 90)
    # Verify that the bullet has degraded in damage
    assert_eq(test_bullet.__damage, 8)

    # Inflict damage on the second test creep
    test_bullet._inflict_damange(second_test_creep)

    # Verify that the second test creep has taken the expedted amount of damage
    assert_eq(second_test_creep.get_curr_health(), 92)
    # Verify that the bullet has degraded in damage
    assert_eq(test_bullet.__damage, 6)

    # Clean up
    first_test_creep.queue_free()
    second_test_creep.queue_free()
    test_bullet.queue_free()
