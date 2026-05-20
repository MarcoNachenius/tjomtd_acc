extends Creep
class_name Mummy

@export var CRAWL_ANIMATIONS: AnimatedSprite2D

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
    

# ***************
# PRIVATE METHODS
# ***************
