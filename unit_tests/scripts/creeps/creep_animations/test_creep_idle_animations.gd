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

func test_centipede_idle_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_n"), "Centipede creep has 'idle_n animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_ne"), "Centipede creep has 'idle_ne animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_e"), "Centipede creep has 'idle_e animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_se"), "Centipede creep has 'idle_se animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_s"), "Centipede creep has 'idle_s animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_sw"), "Centipede creep has 'idle_sw animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_w"), "Centipede creep has 'idle_w animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_nw"), "Centipede creep has 'idle_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_demon_idle_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_n"), "Demon creep has 'idle_n animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_ne"), "Demon creep has 'idle_ne animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_e"), "Demon creep has 'idle_e animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_se"), "Demon creep has 'idle_se animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_s"), "Demon creep has 'idle_s animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_sw"), "Demon creep has 'idle_sw animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_w"), "Demon creep has 'idle_w animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_nw"), "Demon creep has 'idle_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_red_spider_idle_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_n"), "Red Spider creep has 'idle_n animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_ne"), "Red Spider creep has 'idle_ne animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_e"), "Red Spider creep has 'idle_e animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_se"), "Red Spider creep has 'idle_se animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_s"), "Red Spider creep has 'idle_s animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_sw"), "Red Spider creep has 'idle_sw animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_w"), "Red Spider creep has 'idle_w animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_nw"), "Red Spider creep has 'idle_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_blue_spider_idle_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.BLUE_SPIDER].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_n"), "Red Spider creep has 'idle_n animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_ne"), "Red Spider creep has 'idle_ne animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_e"), "Red Spider creep has 'idle_e animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_se"), "Red Spider creep has 'idle_se animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_s"), "Red Spider creep has 'idle_s animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_sw"), "Red Spider creep has 'idle_sw animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_w"), "Red Spider creep has 'idle_w animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_nw"), "Red Spider creep has 'idle_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_human_idle_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.HUMAN].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_n"), "Human creep has 'idle_n animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_ne"), "Human creep has 'idle_ne animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_e"), "Human creep has 'idle_e animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_se"), "Human creep has 'idle_se animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_s"), "Human creep has 'idle_s animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_sw"), "Human creep has 'idle_sw animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_w"), "Human creep has 'idle_w animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_nw"), "Human creep has 'idle_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_pumpkin_idle_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.PUMPKIN].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_n"), "Pumpkin creep has 'idle_n animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_ne"), "Pumpkin creep has 'idle_ne animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_e"), "Pumpkin creep has 'idle_e animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_se"), "Pumpkin creep has 'idle_se animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_s"), "Pumpkin creep has 'idle_s animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_sw"), "Pumpkin creep has 'idle_sw animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_w"), "Pumpkin creep has 'idle_w animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_nw"), "Pumpkin creep has 'idle_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_tree_idle_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.TREE].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_n"), "Tree creep has 'idle_n animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_ne"), "Tree creep has 'idle_ne animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_e"), "Tree creep has 'idle_e animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_se"), "Tree creep has 'idle_se animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_s"), "Tree creep has 'idle_s animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_sw"), "Tree creep has 'idle_sw animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_w"), "Tree creep has 'idle_w animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_nw"), "Tree creep has 'idle_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_robot_idle_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.ROBOT].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_n"), "Tree creep has 'idle_n animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_ne"), "Tree creep has 'idle_ne animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_e"), "Tree creep has 'idle_e animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_se"), "Tree creep has 'idle_se animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_s"), "Tree creep has 'idle_s animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_sw"), "Tree creep has 'idle_sw animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_w"), "Tree creep has 'idle_w animation'")
    assert_true(dummy_creep.IDLE_ANIMATIONS.sprite_frames.has_animation("idle_nw"), "Tree creep has 'idle_nw animation'")

    # Clean up
    dummy_creep.queue_free()