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

func test_centipede_death_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.CENTIPEDE].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_n"), "Centipede creep has 'death_n animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_ne"), "Centipede creep has 'death_ne animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_e"), "Centipede creep has 'death_e animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_se"), "Centipede creep has 'death_se animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_s"), "Centipede creep has 'death_s animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_sw"), "Centipede creep has 'death_sw animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_w"), "Centipede creep has 'death_w animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_nw"), "Centipede creep has 'death_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_demon_death_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.DEMON].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_n"), "Demon creep has 'death_n animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_ne"), "Demon creep has 'death_ne animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_e"), "Demon creep has 'death_e animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_se"), "Demon creep has 'death_se animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_s"), "Demon creep has 'death_s animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_sw"), "Demon creep has 'death_sw animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_w"), "Demon creep has 'death_w animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_nw"), "Demon creep has 'death_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_red_spider_death_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.RED_SPIDER].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_n"), "Red Spider creep has 'death_n animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_ne"), "Red Spider creep has 'death_ne animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_e"), "Red Spider creep has 'death_e animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_se"), "Red Spider creep has 'death_se animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_s"), "Red Spider creep has 'death_s animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_sw"), "Red Spider creep has 'death_sw animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_w"), "Red Spider creep has 'death_w animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_nw"), "Red Spider creep has 'death_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_blue_spider_death_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.BLUE_SPIDER].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_n"), "Red Spider creep has 'death_n animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_ne"), "Red Spider creep has 'death_ne animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_e"), "Red Spider creep has 'death_e animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_se"), "Red Spider creep has 'death_se animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_s"), "Red Spider creep has 'death_s animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_sw"), "Red Spider creep has 'death_sw animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_w"), "Red Spider creep has 'death_w animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_nw"), "Red Spider creep has 'death_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_human_death_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.HUMAN].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_n"), "Human creep has 'death_n animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_ne"), "Human creep has 'death_ne animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_e"), "Human creep has 'death_e animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_se"), "Human creep has 'death_se animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_s"), "Human creep has 'death_s animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_sw"), "Human creep has 'death_sw animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_w"), "Human creep has 'death_w animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_nw"), "Human creep has 'death_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_pumpkin_death_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.PUMPKIN].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_n"), "Pumpkin creep has 'death_n animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_ne"), "Pumpkin creep has 'death_ne animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_e"), "Pumpkin creep has 'death_e animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_se"), "Pumpkin creep has 'death_se animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_s"), "Pumpkin creep has 'death_s animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_sw"), "Pumpkin creep has 'death_sw animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_w"), "Pumpkin creep has 'death_w animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_nw"), "Pumpkin creep has 'death_nw animation'")

    # Clean up
    dummy_creep.queue_free()

func test_tree_death_animations():
    # Create dummy creep
    var dummy_creep: Creep = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.TREE].instantiate()
    add_child_autofree(dummy_creep)
    dummy_creep.stun(10)

    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_n"), "Tree creep has 'death_n animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_ne"), "Tree creep has 'death_ne animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_e"), "Tree creep has 'death_e animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_se"), "Tree creep has 'death_se animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_s"), "Tree creep has 'death_s animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_sw"), "Tree creep has 'death_sw animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_w"), "Tree creep has 'death_w animation'")
    assert_true(dummy_creep.DEATH_ANIMATIONS.sprite_frames.has_animation("death_nw"), "Tree creep has 'death_nw animation'")

    # Clean up
    dummy_creep.queue_free()