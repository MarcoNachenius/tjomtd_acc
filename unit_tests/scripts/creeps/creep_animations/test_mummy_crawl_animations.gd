extends  GutTest

# Tested Creeps
# =============
# - Mummy

func before_each():
	await get_tree().process_frame

func test_mummy_crawl_animations():
	# Create dummy creep
	var dummy_creep: Mummy = CreepConstants.CreepPreloads[CreepConstants.CreepIDs.MUMMY].instantiate()
	add_child_autofree(dummy_creep)
	dummy_creep.stun(10)

	assert_true(dummy_creep.CRAWL_ANIMATIONS.sprite_frames.has_animation("crawl_n"), "Centipede creep has 'crawl_n animation'")
	assert_true(dummy_creep.CRAWL_ANIMATIONS.sprite_frames.has_animation("crawl_ne"), "Centipede creep has 'crawl_ne animation'")
	assert_true(dummy_creep.CRAWL_ANIMATIONS.sprite_frames.has_animation("crawl_e"), "Centipede creep has 'crawl_e animation'")
	assert_true(dummy_creep.CRAWL_ANIMATIONS.sprite_frames.has_animation("crawl_se"), "Centipede creep has 'crawl_se animation'")
	assert_true(dummy_creep.CRAWL_ANIMATIONS.sprite_frames.has_animation("crawl_s"), "Centipede creep has 'crawl_s animation'")
	assert_true(dummy_creep.CRAWL_ANIMATIONS.sprite_frames.has_animation("crawl_sw"), "Centipede creep has 'crawl_sw animation'")
	assert_true(dummy_creep.CRAWL_ANIMATIONS.sprite_frames.has_animation("crawl_w"), "Centipede creep has 'crawl_w animation'")
	assert_true(dummy_creep.CRAWL_ANIMATIONS.sprite_frames.has_animation("crawl_nw"), "Centipede creep has 'crawl_nw animation'")
