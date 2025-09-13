extends VBoxContainer
class_name UpgradeTowerButtonsVBox

signal upgrade_tower_button_pressed(tower_id: TowerConstants.TowerIDs)

# TOMBSTONE
@export var TOMBSTONE_LVL_1_BUTTON: Button
@export var TOMBSTONE_LVL_2_BUTTON: Button
@export var TOMBSTONE_LVL_3_BUTTON: Button
# SAM SITE
@export var SAM_SITE_LVL_1_BUTTON: Button
@export var SAM_SITE_LVL_2_BUTTON: Button
@export var SAM_SITE_LVL_3_BUTTON: Button
# LAVA POOL
@export var LAVA_POOL_LVL_1_BUTTON: Button
@export var LAVA_POOL_LVL_2_BUTTON: Button
@export var LAVA_POOL_LVL_3_BUTTON: Button
# ICE SHARD
@export var ICE_SHARD_LVL_1_BUTTON: Button
@export var ICE_SHARD_LVL_2_BUTTON: Button
@export var ICE_SHARD_LVL_3_BUTTON: Button
# EMP STUNNER
@export var EMP_STUNNER_LVL_1_BUTTON: Button
@export var EMP_STUNNER_LVL_2_BUTTON: Button
@export var EMP_STUNNER_LVL_3_BUTTON: Button
# GATLING GUN
@export var GATLING_GUN_LVL_1_BUTTON: Button
@export var GATLING_GUN_LVL_2_BUTTON: Button
# SHARP SHOOTER
@export var SHARP_SHOOTER_LVL_1_BUTTON: Button
@export var SHARP_SHOOTER_LVL_2_BUTTON: Button


@onready var ALL_BUTTONS: Array[Button] = [
	# TOMBSTONE
	TOMBSTONE_LVL_1_BUTTON,
	TOMBSTONE_LVL_2_BUTTON,
	TOMBSTONE_LVL_3_BUTTON,
	# SAM SITE
	SAM_SITE_LVL_1_BUTTON,
	SAM_SITE_LVL_2_BUTTON,
	SAM_SITE_LVL_3_BUTTON,
	# LAVA POOL
	LAVA_POOL_LVL_1_BUTTON,
	LAVA_POOL_LVL_2_BUTTON,
	LAVA_POOL_LVL_3_BUTTON,
	# ICE SHARD
	ICE_SHARD_LVL_1_BUTTON,
	ICE_SHARD_LVL_2_BUTTON,
	ICE_SHARD_LVL_3_BUTTON,
	# EMP STUNNER
	EMP_STUNNER_LVL_1_BUTTON,
	EMP_STUNNER_LVL_2_BUTTON,
	EMP_STUNNER_LVL_3_BUTTON,
	# GATLING GUN
	GATLING_GUN_LVL_1_BUTTON,
	GATLING_GUN_LVL_2_BUTTON,
	# SHARP SHOOTER
	SHARP_SHOOTER_LVL_1_BUTTON,
	SHARP_SHOOTER_LVL_2_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON: Dictionary[TowerConstants.TowerIDs, Button] = {
	# TOMBSTONE
	TowerConstants.TowerIDs.TOMBSTONE_LVL_1: TOMBSTONE_LVL_1_BUTTON,
	TowerConstants.TowerIDs.TOMBSTONE_LVL_2: TOMBSTONE_LVL_2_BUTTON,
	TowerConstants.TowerIDs.TOMBSTONE_LVL_3: TOMBSTONE_LVL_3_BUTTON,
	# SAM SITE
	TowerConstants.TowerIDs.SAM_SITE_LVL_1: SAM_SITE_LVL_1_BUTTON,
	TowerConstants.TowerIDs.SAM_SITE_LVL_2: SAM_SITE_LVL_2_BUTTON,
	TowerConstants.TowerIDs.SAM_SITE_LVL_3: SAM_SITE_LVL_3_BUTTON,
	# LAVA POOL
	TowerConstants.TowerIDs.LAVA_POOL_LVL_1: LAVA_POOL_LVL_1_BUTTON,
	TowerConstants.TowerIDs.LAVA_POOL_LVL_2: LAVA_POOL_LVL_2_BUTTON,
	TowerConstants.TowerIDs.LAVA_POOL_LVL_3: LAVA_POOL_LVL_3_BUTTON,
	# ICE SHARD
	TowerConstants.TowerIDs.ICE_SHARD_LVL_1: ICE_SHARD_LVL_1_BUTTON,
	TowerConstants.TowerIDs.ICE_SHARD_LVL_2: ICE_SHARD_LVL_2_BUTTON,
	TowerConstants.TowerIDs.ICE_SHARD_LVL_3: ICE_SHARD_LVL_3_BUTTON,
	# EMP STUNNER
	TowerConstants.TowerIDs.EMP_STUNNER_LVL_1: EMP_STUNNER_LVL_1_BUTTON,
	TowerConstants.TowerIDs.EMP_STUNNER_LVL_2: EMP_STUNNER_LVL_2_BUTTON,
	TowerConstants.TowerIDs.EMP_STUNNER_LVL_3: EMP_STUNNER_LVL_3_BUTTON,
	# GATLING GUN
	TowerConstants.TowerIDs.GATLING_GUN_LVL_1: GATLING_GUN_LVL_1_BUTTON,
	TowerConstants.TowerIDs.GATLING_GUN_LVL_2: GATLING_GUN_LVL_2_BUTTON,
	# SHARP SHOOTER
	TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_1: SHARP_SHOOTER_LVL_1_BUTTON,
	TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_2: SHARP_SHOOTER_LVL_2_BUTTON,
}

var TOWER_ID_TO_BUTTON_PRESSED_CALLABLES: Dictionary[TowerConstants.TowerIDs, Callable] = {
	# TOMBSTONE
	TowerConstants.TowerIDs.TOMBSTONE_LVL_1: _on_tombstone_lvl_1_button_pressed,
	TowerConstants.TowerIDs.TOMBSTONE_LVL_2: _on_tombstone_lvl_2_button_pressed,
	TowerConstants.TowerIDs.TOMBSTONE_LVL_3: _on_tombstone_lvl_3_button_pressed,
	# SAM SITE
	TowerConstants.TowerIDs.SAM_SITE_LVL_1: _on_sam_site_lvl_1_button_pressed,
	TowerConstants.TowerIDs.SAM_SITE_LVL_2: _on_sam_site_lvl_2_button_pressed,
	TowerConstants.TowerIDs.SAM_SITE_LVL_3: _on_sam_site_lvl_3_button_pressed,
	# LAVA POOL
	TowerConstants.TowerIDs.LAVA_POOL_LVL_1: _on_lava_pool_lvl_1_button_pressed,
	TowerConstants.TowerIDs.LAVA_POOL_LVL_2: _on_lava_pool_lvl_2_button_pressed,
	TowerConstants.TowerIDs.LAVA_POOL_LVL_3: _on_lava_pool_lvl_3_button_pressed,
	# ICE SHARD
	TowerConstants.TowerIDs.ICE_SHARD_LVL_1: _on_ice_shard_lvl_1_button_pressed,
	TowerConstants.TowerIDs.ICE_SHARD_LVL_2: _on_ice_shard_lvl_2_button_pressed,
	TowerConstants.TowerIDs.ICE_SHARD_LVL_3: _on_ice_shard_lvl_3_button_pressed,
	# EMP STUNNER
	TowerConstants.TowerIDs.EMP_STUNNER_LVL_1: _on_emp_stunner_lvl_1_button_pressed,
	TowerConstants.TowerIDs.EMP_STUNNER_LVL_2: _on_emp_stunner_lvl_2_button_pressed,
	TowerConstants.TowerIDs.EMP_STUNNER_LVL_3: _on_emp_stunner_lvl_3_button_pressed,
	# GATLING GUN
	TowerConstants.TowerIDs.GATLING_GUN_LVL_1: _on_gatling_gun_lvl_1_button_pressed,
	TowerConstants.TowerIDs.GATLING_GUN_LVL_2: _on_gatling_gun_lvl_2_button_pressed,
	# SHARP SHOOTER
	TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_1: _on_sharp_shooter_lvl_1_button_pressed,
	TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_2: _on_sharp_shooter_lvl_2_button_pressed,
}


func _ready() -> void:
	# Connect all button pressed signals to their respective callables
	for tower_id in TOWER_ID_TO_BUTTON_PRESSED_CALLABLES.keys():
		var button: Button = TOWER_ID_TO_BUTTON[tower_id]
		var callable: Callable = TOWER_ID_TO_BUTTON_PRESSED_CALLABLES[tower_id]
		button.pressed.connect(callable)


# ==============
# PUBLIC METHODS
# ==============
func hide_all_buttons() -> void:
	for button in ALL_BUTTONS:
		button.visible = false

func show_buttons(towerIDs: Array[TowerConstants.TowerIDs]) -> void:
	for tower_id in towerIDs:
		TOWER_ID_TO_BUTTON[tower_id].visible = true

# ==============================
# BUTTON PRESSED SIGNAL EMITTERS
# ==============================
# TOMBSTONE
func _on_tombstone_lvl_1_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.TOMBSTONE_LVL_1)

func _on_tombstone_lvl_2_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.TOMBSTONE_LVL_2)

func _on_tombstone_lvl_3_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.TOMBSTONE_LVL_3)

# SAM SITE
func _on_sam_site_lvl_1_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.SAM_SITE_LVL_1)

func _on_sam_site_lvl_2_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.SAM_SITE_LVL_2)

func _on_sam_site_lvl_3_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.SAM_SITE_LVL_3)

# LAVA POOL
func _on_lava_pool_lvl_1_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.LAVA_POOL_LVL_1)

func _on_lava_pool_lvl_2_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.LAVA_POOL_LVL_2)

func _on_lava_pool_lvl_3_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.LAVA_POOL_LVL_3)

# ICE SHARD
func _on_ice_shard_lvl_1_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.ICE_SHARD_LVL_1)

func _on_ice_shard_lvl_2_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.ICE_SHARD_LVL_2)

func _on_ice_shard_lvl_3_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.ICE_SHARD_LVL_3)

# EMP STUNNER
func _on_emp_stunner_lvl_1_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.EMP_STUNNER_LVL_1)

func _on_emp_stunner_lvl_2_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.EMP_STUNNER_LVL_2)

func _on_emp_stunner_lvl_3_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.EMP_STUNNER_LVL_3)

# GATLING GUN
func _on_gatling_gun_lvl_1_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.GATLING_GUN_LVL_1)

func _on_gatling_gun_lvl_2_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.GATLING_GUN_LVL_2)

# SHARP SHOOTER
func _on_sharp_shooter_lvl_1_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_1)

func _on_sharp_shooter_lvl_2_button_pressed() -> void:
	upgrade_tower_button_pressed.emit(TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_2)
