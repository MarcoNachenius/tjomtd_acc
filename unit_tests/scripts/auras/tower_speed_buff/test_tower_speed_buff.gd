extends GutTest

func before_each():
	await get_tree().process_frame
	await get_tree().physics_frame

func test_speed_aura_buff():
	# TEST VALUES
	const STARTING_SPEED: float = 0.5
	const SPEED_INCREASE_FACTOR_VALUE: float = 0.5
	const EXPECTED_BUFFED_SPEED: float = 0.25
	const EXPECTED_SPEED_BUFF_AMOUNT: float = 0.25

	# Black Marble Level 1 tower is chosen because it does not contain any secornady projectile
	# spawners or auras which might interfere with solely testing entry of a single speed aura. 
	var test_tower: Tower = TowerConstants.ALL_TOWER_LOADS[TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1].instantiate()

	# Set primary projectile spawner's starting speed
	test_tower.PRIMARY_PROJECTILE_SPAWNER.__cooldown_duration = STARTING_SPEED

	# Add tower to scene
	add_child_autofree(test_tower)
	await get_tree().process_frame # let _ready run & signals connect
	await get_tree().physics_frame # register shapes this tick

	# Ensure tower's detection area has been created
	assert_not_null(test_tower.DETECTION_AREA, "Tower detection area has been created")

	# Ensure starting speed has been assigned as expected
	assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.__cooldown_duration, STARTING_SPEED)

	# Ensure projectile spawner's initial speed singleton has been properly assigned
	assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.INITIAL_SPEED, STARTING_SPEED)

	# Create speed aura
	var speed_aura: TowerSpeedAura = TowerAuraConstants.TOWER_SPEED_AURA_PRELOAD.instantiate()
	speed_aura.SPEED_INCREASE_FACTOR = SPEED_INCREASE_FACTOR_VALUE

	# Add speed aura to scene
	add_child_autofree(speed_aura)
	await get_tree().process_frame # added to tree
	await get_tree().physics_frame # shapes registered
	await get_tree().physics_frame # overlaps resolved & signals emitted

	# Ensure speed aura and tower have the same global position, thus ensuring that
	# the speed aura will be able to enter the tower's detection area.
	assert_eq(speed_aura.global_position, test_tower.global_position, "Speed aura and tower have the same global positions")

	# Ensure projectile spawner's speed has been increased
	assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.__cooldown_duration, EXPECTED_BUFFED_SPEED)

	# Ensure total speed buff amount gets updated 
	assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.total_bonus_speed(), EXPECTED_SPEED_BUFF_AMOUNT)

	# Ensure speed aura is being tracked by tower's aura manager
	assert_true(test_tower.TOWER_AURA_MANAGER.__active_speed_auras.keys().has(speed_aura), "Aura manager is tracking speed aura")
	assert_eq(test_tower.TOWER_AURA_MANAGER.__active_speed_auras[speed_aura], EXPECTED_SPEED_BUFF_AMOUNT, "Speed buff amount is being correctly tracked")

	# Remove speed aura
	speed_aura.queue_free()
	await get_tree().process_frame # node is actually freed here
	await get_tree().physics_frame # broadphase updates; exit likely emitted
	await get_tree().physics_frame # ensure everything settles

	# Ensure speed aura is no longer being tracked by tower's aura manager
	assert_true(test_tower.TOWER_AURA_MANAGER.__active_speed_auras.is_empty(), "Speed aura no longer being tracked by aura manager")

	# Ensure primary projectile spawner's speed has been reset to initial amount
	assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.__cooldown_duration, STARTING_SPEED)

	# Ensure bonus speed amount is no longer being displayed
	assert_eq(test_tower.PRIMARY_PROJECTILE_SPAWNER.total_bonus_speed(), 0.0, "Bonus speed no longer being displayed")

	# Clean up
	test_tower.queue_free()
