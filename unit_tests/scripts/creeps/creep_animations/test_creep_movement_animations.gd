extends  GutTest

# Tested Creeps
# =============
# - Centipede
# - Demon
# - Red Spider
# - Blue Spider
# - Human
# - Pumpkin


func before_each():
    await get_tree().process_frame

func test_centipede_movement_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_n"), "Centipede creep has 'move_n animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_ne"), "Centipede creep has 'move_ne animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_e"), "Centipede creep has 'move_e animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_se"), "Centipede creep has 'move_se animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_s"), "Centipede creep has 'move_s animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_sw"), "Centipede creep has 'move_sw animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_w"), "Centipede creep has 'move_w animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_nw"), "Centipede creep has 'move_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_demon_movement_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_n"), "Demon creep has 'move_n animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_ne"), "Demon creep has 'move_ne animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_e"), "Demon creep has 'move_e animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_se"), "Demon creep has 'move_se animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_s"), "Demon creep has 'move_s animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_sw"), "Demon creep has 'move_sw animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_w"), "Demon creep has 'move_w animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_nw"), "Demon creep has 'move_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_red_spider_movement_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_n"), "Red Spider creep has 'move_n animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_ne"), "Red Spider creep has 'move_ne animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_e"), "Red Spider creep has 'move_e animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_se"), "Red Spider creep has 'move_se animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_s"), "Red Spider creep has 'move_s animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_sw"), "Red Spider creep has 'move_sw animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_w"), "Red Spider creep has 'move_w animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_nw"), "Red Spider creep has 'move_nw animation'")

    # Clean up
    dummy_creep.queue_free()


func test_blue_spider_movement_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.BLUE_SPIDER].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_n"), "Blue Spider creep has 'move_n animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_ne"), "Blue Spider creep has 'move_ne animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_e"), "Blue Spider creep has 'move_e animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_se"), "Blue Spider creep has 'move_se animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_s"), "Blue Spider creep has 'move_s animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_sw"), "Blue Spider creep has 'move_sw animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_w"), "Blue Spider creep has 'move_w animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_nw"), "Blue Spider creep has 'move_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_human_movement_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.HUMAN].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_n"), "Human creep has 'move_n animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_ne"), "Human creep has 'move_ne animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_e"), "Human creep has 'move_e animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_se"), "Human creep has 'move_se animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_s"), "Human creep has 'move_s animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_sw"), "Human creep has 'move_sw animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_w"), "Human creep has 'move_w animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_nw"), "Human creep has 'move_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_pumpkin_movement_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.PUMPKIN].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_n"), "Human creep has 'move_n animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_ne"), "Human creep has 'move_ne animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_e"), "Human creep has 'move_e animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_se"), "Human creep has 'move_se animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_s"), "Human creep has 'move_s animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_sw"), "Human creep has 'move_sw animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_w"), "Human creep has 'move_w animation'")
    assert_true(dummy_creep.MOVEMENT_ANIMATIONS.sprite_frames.has_animation("move_nw"), "Human creep has 'move_nw animation'")

    # Clean up
    dummy_creep.queue_free()