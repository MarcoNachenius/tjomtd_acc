extends GutTest

func before_each():
    # Ensure previous nodes are fully freed.
    await get_tree().process_frame


# +++++++++++
# HOLD SLATES
# +++++++++++
func test_hold_slate_lvl_1_load():
    var slate_scene = SlateConstants.SLATE_LOADS[SlateConstants.SlateIDs.HOLD_SLATE_LVL_1].instantiate()
    add_child_autofree(slate_scene)
    await get_tree().process_frame
    assert_not_null(slate_scene, "HOLD_SLATE_LVL_1 successfully loaded and instantiated.")
    # Clean up
    slate_scene.queue_free()

func test_hold_slate_lvl_2_load():
    var slate_scene = SlateConstants.SLATE_LOADS[SlateConstants.SlateIDs.HOLD_SLATE_LVL_2].instantiate()
    add_child_autofree(slate_scene)
    await get_tree().process_frame
    assert_not_null(slate_scene, "HOLD_SLATE_LVL_2 successfully loaded and instantiated.")
    # Clean up
    slate_scene.queue_free()

func test_hold_slate_lvl_3_load():
    var slate_scene = SlateConstants.SLATE_LOADS[SlateConstants.SlateIDs.HOLD_SLATE_LVL_3].instantiate()
    add_child_autofree(slate_scene)
    await get_tree().process_frame
    assert_not_null(slate_scene, "HOLD_SLATE_LVL_3 successfully loaded and instantiated.")
    # Clean up
    slate_scene.queue_free()