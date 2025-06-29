extends HBoxContainer
class_name ExtendedUpgradesContainer

@export var TOMBSTONE_LVL_2_BUTTON: Button
@export var TOMBSTONE_LVL_3_BUTTON: Button
@export var SAM_SITE_LVL_2_BUTTON: Button
@export var SAM_SITE_LVL_3_BUTTON: Button
@export var LAVA_POOL_LVL_2_BUTTON: Button
@export var LAVA_POOL_LVL_3_BUTTON: Button
@export var ICE_SHARD_LVL_2_BUTTON: Button
@export var ICE_SHARD_LVL_3_BUTTON: Button
@export var EMP_STUNNER_LVL_2_BUTTON: Button
@export var EMP_STUNNER_LVL_3_BUTTON: Button
@export var GATLING_GUN_LVL_2_BUTTON: Button
@export var SHARP_SHOOTER_LVL_2_BUTTON: Button

@onready var ALL_BUTTONS: Array[Button] = [
    TOMBSTONE_LVL_3_BUTTON,
    TOMBSTONE_LVL_2_BUTTON,
    SAM_SITE_LVL_2_BUTTON,
    SAM_SITE_LVL_3_BUTTON,
    LAVA_POOL_LVL_2_BUTTON,
    LAVA_POOL_LVL_3_BUTTON,
    ICE_SHARD_LVL_2_BUTTON,
    ICE_SHARD_LVL_3_BUTTON,
    EMP_STUNNER_LVL_2_BUTTON,
    EMP_STUNNER_LVL_3_BUTTON,
    GATLING_GUN_LVL_2_BUTTON,
    SHARP_SHOOTER_LVL_2_BUTTON,
]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
    TowerConstants.TowerIDs.TOMBSTONE_LVL_2: TOMBSTONE_LVL_2_BUTTON,
    TowerConstants.TowerIDs.TOMBSTONE_LVL_3: TOMBSTONE_LVL_3_BUTTON,
    TowerConstants.TowerIDs.SAM_SITE_LVL_2: SAM_SITE_LVL_2_BUTTON,
    TowerConstants.TowerIDs.SAM_SITE_LVL_3: SAM_SITE_LVL_3_BUTTON,
    TowerConstants.TowerIDs.LAVA_POOL_LVL_2: LAVA_POOL_LVL_2_BUTTON,
    TowerConstants.TowerIDs.LAVA_POOL_LVL_3: LAVA_POOL_LVL_3_BUTTON,
    TowerConstants.TowerIDs.ICE_SHARD_LVL_2: ICE_SHARD_LVL_2_BUTTON,
    TowerConstants.TowerIDs.ICE_SHARD_LVL_3: ICE_SHARD_LVL_3_BUTTON,
    TowerConstants.TowerIDs.EMP_STUNNER_LVL_2: EMP_STUNNER_LVL_2_BUTTON,
    TowerConstants.TowerIDs.EMP_STUNNER_LVL_3: EMP_STUNNER_LVL_3_BUTTON,
    TowerConstants.TowerIDs.GATLING_GUN_LVL_2: GATLING_GUN_LVL_2_BUTTON,
    TowerConstants.TowerIDs.SHARP_SHOOTER_LVL_2: SHARP_SHOOTER_LVL_2_BUTTON,
}

func _ready() -> void:
    # Add tower prices to button text
    for tower_id in TOWER_ID_TO_BUTTON_DICT.keys():
        var button: Button = TOWER_ID_TO_BUTTON_DICT[tower_id]
        button.text += " (" + str(TowerConstants.TowerPrices[tower_id]) + ")"
    
    # Ensure all button exports have been assigned.
    assert(TOMBSTONE_LVL_2_BUTTON, "TOMBSTONE_LVL_2_BUTTON is not assigned in the inspector.")
    assert(TOMBSTONE_LVL_3_BUTTON, "TOMBSTONE_LVL_3_BUTTON is not assigned in the inspector.")
    assert(SAM_SITE_LVL_2_BUTTON, "SAM_SITE_LVL_2_BUTTON is not assigned in the inspector.")
    assert(SAM_SITE_LVL_3_BUTTON, "SAM_SITE_LVL_3_BUTTON is not assigned in the inspector.")
    assert(LAVA_POOL_LVL_2_BUTTON, "LAVA_POOL_LVL_2_BUTTON is not assigned in the inspector.")
    assert(LAVA_POOL_LVL_3_BUTTON, "LAVA_POOL_LVL_3_BUTTON is not assigned in the inspector.")
    assert(ICE_SHARD_LVL_2_BUTTON, "ICE_SHARD_LVL_2_BUTTON is not assigned in the inspector.")
    assert(ICE_SHARD_LVL_3_BUTTON, "ICE_SHARD_LVL_3_BUTTON is not assigned in the inspector.")
    assert(EMP_STUNNER_LVL_2_BUTTON, "EMP_STUNNER_LVL_2_BUTTON is not assigned in the inspector.")
    assert(EMP_STUNNER_LVL_3_BUTTON, "EMP_STUNNER_LVL_3_BUTTON is not assigned in the inspector.")
    assert(GATLING_GUN_LVL_2_BUTTON, "GATLING_GUN_LVL_2_BUTTON is not assigned in the inspector.")
    assert(SHARP_SHOOTER_LVL_2_BUTTON, "SHARP_SHOOTER_LVL_2_BUTTON is not assigned in the inspector.")

# PUBLIC METHODS
func hide_all_buttons():
    for button in ALL_BUTTONS:
        button.visible = false