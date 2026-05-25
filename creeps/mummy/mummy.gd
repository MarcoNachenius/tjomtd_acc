extends Creep
class_name Mummy

@export var CRAWL_ANIMATIONS: AnimatedSprite2D
## CRAWL SPEED FACTOR: Multiplier applied to the creep's speed when crawling. 
## This allows for fine-tuning the crawl speed without affecting the base movement speed.
@export var CRAWL_SPEED_FACTOR: float = 0.5
## SPEED TO MOVEMENT FPS RATIO: Multiplier to convert the creep's
## speed to the appropriate animation speed for movement animations.
@export var SPEED_TO_CREEP_FPS_RATIO: float = 0.5

var CRAWL_TRIGGER_AREA: CrawlTrigger

# ********
# BUILTINS
# ********
func _ready():
	_create_stun_timer()
	_create_hitbox()
	_set_ordering()
	_switch_state(States.MOVING)

	if FINAL_BOSS_MODE:
		_create_maze_completion_timer()

func _process(delta):
	match __curr_state:
		States.MOVING:
			_handle_movement()
		States.DYING:
			_handle_death()
		States.IDLE:
			_handle_idle()
		States.CRAWLING:
			_handle_crawl()


# ******************
# INHERITEND METHODS
# ******************
func _switch_state(state: States):
	# Update the current state
	__curr_state = state
 
	# Handle state-specific logic based on the new state
	match state:
		States.DYING:
			# Play death sound effect
			if DEATH_AUDIO:
				DEATH_AUDIO.play()
			creep_death.emit(self)
			__death_in_progress = true
			__detectable = false
			# Animation visibility
			DEATH_ANIMATIONS.visible = true
			MOVEMENT_ANIMATIONS.visible = false
			IDLE_ANIMATIONS.visible = false
			CRAWL_ANIMATIONS.visible = false
			DEATH_ANIMATIONS.play(CreepConstants.CompassDirToDeathAnimations[__curr_compass_direction])
		States.IDLE:
			# When creep is crawling and gets stunned, we simply pause the crawl
			# animation and have it play again when starting
			if __curr_state == States.CRAWLING:
				__detectable = true
				CRAWL_ANIMATIONS.pause()
				return
			__detectable = true
			# Animation visibility
			DEATH_ANIMATIONS.visible = false
			MOVEMENT_ANIMATIONS.visible = false
			IDLE_ANIMATIONS.visible = true
			CRAWL_ANIMATIONS.visible = false
		States.MOVING:
			__detectable = true
			__stun_timer.wait_time = 0.0
			# Animation visibility
			DEATH_ANIMATIONS.visible = false
			MOVEMENT_ANIMATIONS.visible = true
			IDLE_ANIMATIONS.visible = false
			CRAWL_ANIMATIONS.visible = false
		States.CRAWLING:
			__detectable = true
			__stun_timer.wait_time = 0.0
			# Animation visibility
			DEATH_ANIMATIONS.visible = false
			MOVEMENT_ANIMATIONS.visible = false
			IDLE_ANIMATIONS.visible = false
			CRAWL_ANIMATIONS.visible = true


func _set_ordering():
	# Scene root
	z_index = 0
	z_as_relative = true
	y_sort_enabled = true
	# Animations
	MOVEMENT_ANIMATIONS.z_index = 0
	MOVEMENT_ANIMATIONS.z_as_relative = true
	MOVEMENT_ANIMATIONS.y_sort_enabled = true
	IDLE_ANIMATIONS.z_index = 0
	IDLE_ANIMATIONS.z_as_relative = true
	IDLE_ANIMATIONS.y_sort_enabled = true
	DEATH_ANIMATIONS.z_index = 0
	DEATH_ANIMATIONS.z_as_relative = true
	DEATH_ANIMATIONS.y_sort_enabled = true
	CRAWL_ANIMATIONS.z_index = 0
	CRAWL_ANIMATIONS.z_as_relative = true
	CRAWL_ANIMATIONS.y_sort_enabled = true  


func _handle_idle():
	# Play idle animation if creep is still stunned and was not crawling before
	# it got stunned. When creep is stunned mid-crawl, the crawl animation simply
	# gets paused. Thus the actual idle animation should not be visible.
	if !__stun_timer.is_stopped():
		if IDLE_ANIMATIONS.visible:
			IDLE_ANIMATIONS.play(CreepConstants.CompassDirToIdleAnimations[__curr_compass_direction])
		return
	
	# Assume stun timer has stopped
	# -----------------------------
	# Check if creep was crawling before it got stunned.
	# Idle animation gets hidden when creep was crawling
	# and gets stunned because we simply pause the crawl animation.
	if !IDLE_ANIMATIONS.visible:
		_switch_state(States.CRAWLING)
		# Reset number of active stun effects
		__num_of_active_stun_effects = 0
		return
	
	# Assume creep was moving before stun
	_switch_state(States.MOVING)
	# Reset number of active stun effects
	__num_of_active_stun_effects = 0


# **********************
# CLASS SPECIFIC METHIDS
# **********************
## Destroys creep if the final point has been reached
func _handle_crawl():
	# Handle point change
	if __distance_to_next_point <= 0:
		# Remove creep from the scene because the end of the path has been reached
		if __penultimate_point_reached:
			end_of_path_reached.emit(self)
			_destroy()
		else: # Handle non-penultimate point change
			_assign_next_point()
		return
	
	# Apply position change
	var position_change: Vector2 = __curr_speed * __curr_velocity * CRAWL_SPEED_FACTOR
	# Calculate the distance travelled in this frame
	var distance_travelled = Vector2.ZERO.distance_to(position_change)
	# Update the distance to the next point
	__distance_to_next_point -= distance_travelled
	# Update the total distance travelled
	__total_distance_travelled += __curr_speed
	# Update the position
	position += position_change
	# Adjust animation speed
	CRAWL_ANIMATIONS.speed_scale = __curr_speed * SPEED_TO_CREEP_FPS_RATIO
	# Play next frame of animation
	CRAWL_ANIMATIONS.play(CreepConstants.CompassDirToCrawlAnimations[__curr_compass_direction])


func _create_crawl_trigger() -> void:
	# Add to scene
	var new_crawl_trigger: CrawlTrigger = CreepConstants.CRAWL_SCANNER_PRELOAD.instantiate()
	add_child(new_crawl_trigger)
	CRAWL_TRIGGER_AREA = new_crawl_trigger
	
	# Connect signals
	CRAWL_TRIGGER_AREA.area_entered.connect(_on_crawl_trigger_entered)
	CRAWL_TRIGGER_AREA.area_exited.connect(_on_crawl_trigger_exited)


func _on_crawl_trigger_entered(_area: Area2D) -> void:
	# Avoid same-frame signal conflict when mummy dies
	if __curr_state == States.DYING:
		return
	_switch_state(States.CRAWLING)


func _on_crawl_trigger_exited(_area: Area2D) -> void:
	# Acoid same-frame signal conflict when mummy dies
	if __curr_state == States.DYING:
		return
	_switch_state(States.MOVING)