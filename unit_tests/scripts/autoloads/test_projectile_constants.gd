extends GutTest

func before_each():
    # Ensure previous nodes are fully freed.
    await get_tree().process_frame

## Test that all the bullets in ProjectileConstants.BULLET_PATHS are valid and extend Projectile
func test_bullet_paths_type_validity():
    for projectile_id in ProjectileConstants.BULLET_PATHS:
        var scene_path: String = ProjectileConstants.BULLET_PATHS[projectile_id]
        var bullet_scene = load(scene_path).instantiate()
        assert_true(bullet_scene is Projectile, "Scene at path %s does not extend Projectile!" % scene_path)

        # Clean up
        add_child_autofree(bullet_scene)
        bullet_scene.queue_free()
