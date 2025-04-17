extends GutTest

func before_each():
	# This function is called before each test case
	# You can set up any necessary state or variables here
	await get_tree().process_frame

func test_targetable_hurtbox_default_non_creation():
	# Create a new instance of the TargetableHurtbox
	var test_projectile: Projectile = Projectile.new()
	add_child_autofree(test_projectile)

	# Ensure retargetable hurtbox is not created by default.
	assert_false(test_projectile.__retargetable, "Retargetable should be false by default") 
	assert_null(test_projectile.__retarget_hurtbox, "Retarget hurtbox should be null before creation when __retargetable is false")

	# Clean up
	test_projectile.queue_free()


func test_targetable_hurtbox_creation_method():
	# Create a new instance of the TargetableHurtbox
	var test_projectile: Projectile = Projectile.new()
	add_child_autofree(test_projectile)

	# Ensure retargetable hurtbox is not created by default.
	assert_false(test_projectile.__retargetable, "Retargetable should be false by default") 
	assert_null(test_projectile.__retarget_hurtbox, "Retarget hurtbox should be null before creation when __retargetable is false")

	# Set values for retargetable hurtbox creation
	test_projectile.__retargetable = true
	test_projectile.__retarget_radius = 100
	test_projectile._create_retarget_hurtbox()

	await get_tree().process_frame

	# Check if the retarget hurtbox was created successfully
	assert_not_null(test_projectile.__retarget_hurtbox, "Retarget hurtbox should be created when __retargetable is true")
	assert_eq(test_projectile.__retarget_hurtbox.get_base_radius(), 100.0, "Retarget hurtbox radius should be set to 100.0")

	# Clean up
	test_projectile.queue_free()


func test_targetable_hurtbox_creation_with_assigned_values():
	# Create a new instance of the TargetableHurtbox
	var test_projectile: Projectile = Projectile.new()
	# Set values for retargetable hurtbox creation
	test_projectile.__retargetable = true
	test_projectile.__retarget_radius = 100
	add_child_autofree(test_projectile)
	await get_tree().process_frame

	# Check if the retarget hurtbox was created successfully
	assert_not_null(test_projectile.__retarget_hurtbox, "Retarget hurtbox should be created when __retargetable is true")
	assert_eq(test_projectile.__retarget_hurtbox.get_base_radius(), 100.0, "Retarget hurtbox radius should be set to 100.0")

	# Clean up
	test_projectile.queue_free()
