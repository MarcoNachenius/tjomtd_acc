extends HBoxContainer
class_name AwaitingSelectionUpgradeTowersContainer


# SINGLETON
@export var CONNECTED_MAIN_HUB: RandomTowerBuildHUD

# EXPORTS
@export var BLACK_MARBLE_LEVEL_2_BUTTON: Button
@export var BLACK_MARBLE_LEVEL_3_BUTTON: Button
@export var BLACK_MARBLE_LEVEL_4_BUTTON: Button
@export var BLACK_MARBLE_LEVEL_5_BUTTON: Button
@export var SUNSTONE_LEVEL_2_BUTTON: Button
@export var SUNSTONE_LEVEL_3_BUTTON: Button
@export var SUNSTONE_LEVEL_4_BUTTON: Button
@export var SUNSTONE_LEVEL_5_BUTTON: Button
@export var SPINEL_LEVEL_2_BUTTON: Button
@export var SPINEL_LEVEL_3_BUTTON: Button
@export var SPINEL_LEVEL_4_BUTTON: Button
@export var SPINEL_LEVEL_5_BUTTON: Button
@export var LARIMAR_LEVEL_2_BUTTON: Button
@export var LARIMAR_LEVEL_3_BUTTON: Button
@export var LARIMAR_LEVEL_4_BUTTON: Button
@export var LARIMAR_LEVEL_5_BUTTON: Button
@export var KUNZITE_LEVEL_2_BUTTON: Button
@export var KUNZITE_LEVEL_3_BUTTON: Button
@export var KUNZITE_LEVEL_4_BUTTON: Button
@export var KUNZITE_LEVEL_5_BUTTON: Button
@export var BISMUTH_LEVEL_2_BUTTON: Button
@export var BISMUTH_LEVEL_3_BUTTON: Button
@export var BISMUTH_LEVEL_4_BUTTON: Button
@export var BISMUTH_LEVEL_5_BUTTON: Button

# CONSTANTS
@onready var ALL_BUTTONS: Array[Button] = [
    BLACK_MARBLE_LEVEL_2_BUTTON,
    BLACK_MARBLE_LEVEL_3_BUTTON,
    BLACK_MARBLE_LEVEL_4_BUTTON,
    BLACK_MARBLE_LEVEL_5_BUTTON,
    SUNSTONE_LEVEL_2_BUTTON,
    SUNSTONE_LEVEL_3_BUTTON,
    SUNSTONE_LEVEL_4_BUTTON,
    SUNSTONE_LEVEL_5_BUTTON,
    SPINEL_LEVEL_2_BUTTON,
    SPINEL_LEVEL_3_BUTTON,
    SPINEL_LEVEL_4_BUTTON,
    SPINEL_LEVEL_5_BUTTON,
    LARIMAR_LEVEL_2_BUTTON,
    LARIMAR_LEVEL_3_BUTTON,
    LARIMAR_LEVEL_4_BUTTON,
    LARIMAR_LEVEL_5_BUTTON,
    KUNZITE_LEVEL_2_BUTTON,
    KUNZITE_LEVEL_3_BUTTON,
    KUNZITE_LEVEL_4_BUTTON,
    KUNZITE_LEVEL_5_BUTTON,
    BISMUTH_LEVEL_2_BUTTON,
    BISMUTH_LEVEL_3_BUTTON,
    BISMUTH_LEVEL_4_BUTTON,
    BISMUTH_LEVEL_5_BUTTON,

]

@onready var TOWER_ID_TO_BUTTON_DICT: Dictionary[TowerConstants.TowerIDs, Button] = {
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2: BLACK_MARBLE_LEVEL_2_BUTTON,
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3: BLACK_MARBLE_LEVEL_3_BUTTON,
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4: BLACK_MARBLE_LEVEL_4_BUTTON,
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_5: BLACK_MARBLE_LEVEL_5_BUTTON,
    TowerConstants.TowerIDs.SUNSTONE_LVL_2: SUNSTONE_LEVEL_2_BUTTON,
    TowerConstants.TowerIDs.SUNSTONE_LVL_3: SUNSTONE_LEVEL_3_BUTTON,
    TowerConstants.TowerIDs.SUNSTONE_LVL_4: SUNSTONE_LEVEL_4_BUTTON,
    TowerConstants.TowerIDs.SUNSTONE_LVL_5: SUNSTONE_LEVEL_5_BUTTON,
    TowerConstants.TowerIDs.SPINEL_LVL_2: SPINEL_LEVEL_2_BUTTON,
    TowerConstants.TowerIDs.SPINEL_LVL_3: SPINEL_LEVEL_3_BUTTON,
    TowerConstants.TowerIDs.SPINEL_LVL_4: SPINEL_LEVEL_4_BUTTON,
    TowerConstants.TowerIDs.SPINEL_LVL_5: SPINEL_LEVEL_5_BUTTON,
    TowerConstants.TowerIDs.LARIMAR_LVL_2: LARIMAR_LEVEL_2_BUTTON,
    TowerConstants.TowerIDs.LARIMAR_LVL_3: LARIMAR_LEVEL_3_BUTTON,
    TowerConstants.TowerIDs.LARIMAR_LVL_4: LARIMAR_LEVEL_4_BUTTON,
    TowerConstants.TowerIDs.LARIMAR_LVL_5: LARIMAR_LEVEL_5_BUTTON,
    TowerConstants.TowerIDs.KUNZITE_LVL_2: KUNZITE_LEVEL_2_BUTTON,
    TowerConstants.TowerIDs.KUNZITE_LVL_3: KUNZITE_LEVEL_3_BUTTON,
    TowerConstants.TowerIDs.KUNZITE_LVL_4: KUNZITE_LEVEL_4_BUTTON,
    TowerConstants.TowerIDs.KUNZITE_LVL_5: KUNZITE_LEVEL_5_BUTTON,
    TowerConstants.TowerIDs.BISMUTH_LVL_2: BISMUTH_LEVEL_2_BUTTON,
    TowerConstants.TowerIDs.BISMUTH_LVL_3: BISMUTH_LEVEL_3_BUTTON,
    TowerConstants.TowerIDs.BISMUTH_LVL_4: BISMUTH_LEVEL_4_BUTTON,
    TowerConstants.TowerIDs.BISMUTH_LVL_5: BISMUTH_LEVEL_5_BUTTON,
}

@onready var AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER_BUTTON_CALLBACKS: Dictionary[Button, Callable] = {
    BLACK_MARBLE_LEVEL_2_BUTTON: _on_black_marble_level_2_button_pressed,
    BLACK_MARBLE_LEVEL_3_BUTTON: _on_black_marble_level_3_button_pressed,
    BLACK_MARBLE_LEVEL_4_BUTTON: _on_black_marble_level_4_button_pressed,
    BLACK_MARBLE_LEVEL_5_BUTTON: _on_black_marble_level_5_button_pressed,
    SUNSTONE_LEVEL_2_BUTTON: _on_sunstone_level_2_button_pressed,
    SUNSTONE_LEVEL_3_BUTTON: _on_sunstone_level_3_button_pressed,
    SUNSTONE_LEVEL_4_BUTTON: _on_sunstone_level_4_button_pressed,
    SUNSTONE_LEVEL_5_BUTTON: _on_sunstone_level_5_button_pressed,
    SPINEL_LEVEL_2_BUTTON: _on_spinel_level_2_button_pressed,
    SPINEL_LEVEL_3_BUTTON: _on_spinel_level_3_button_pressed,
    SPINEL_LEVEL_4_BUTTON: _on_spinel_level_4_button_pressed,
    SPINEL_LEVEL_5_BUTTON: _on_spinel_level_5_button_pressed,
    LARIMAR_LEVEL_2_BUTTON: _on_larimar_level_2_button_pressed,
    LARIMAR_LEVEL_3_BUTTON: _on_larimar_level_3_button_pressed,
    LARIMAR_LEVEL_4_BUTTON: _on_larimar_level_4_button_pressed,
    LARIMAR_LEVEL_5_BUTTON: _on_larimar_level_5_button_pressed,
    KUNZITE_LEVEL_2_BUTTON: _on_kunzite_level_2_button_pressed,
    KUNZITE_LEVEL_3_BUTTON: _on_kunzite_level_3_button_pressed,
    KUNZITE_LEVEL_4_BUTTON: _on_kunzite_level_4_button_pressed,
    KUNZITE_LEVEL_5_BUTTON: _on_kunzite_level_5_button_pressed,
    BISMUTH_LEVEL_2_BUTTON: _on_bismuth_level_2_button_pressed,
    BISMUTH_LEVEL_3_BUTTON: _on_bismuth_level_3_button_pressed,
    BISMUTH_LEVEL_4_BUTTON: _on_bismuth_level_4_button_pressed,
    BISMUTH_LEVEL_5_BUTTON: _on_bismuth_level_5_button_pressed,
    
}

# PUBLIC METHODS
func hide_all_buttons():
    for button in ALL_BUTTONS:
        button.visible = false


func _ready() -> void:
    _connect_awaiting_selection_upgrade_towers_container_signals()
    hide_all_buttons()


func _connect_awaiting_selection_upgrade_towers_container_signals():
    for button in ALL_BUTTONS:
        # Retrieve the callback function from the dictionary using the button as the key.
        button.pressed.connect(AWAITING_SELECTION_COMPOUND_UPGRADE_TOWERS_CONTAINER_BUTTON_CALLBACKS[button])

# BLACK MARBLE
# ------------
func _on_black_marble_level_2_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2)

func _on_black_marble_level_3_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3)

func _on_black_marble_level_4_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4)

func _on_black_marble_level_5_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BLACK_MARBLE_LVL_5)

# SUNSTONE
# --------
func _on_sunstone_level_2_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_2)

func _on_sunstone_level_3_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_3)

func _on_sunstone_level_4_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_4)

func _on_sunstone_level_5_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SUNSTONE_LVL_5)

# SPINEL
# ------
func _on_spinel_level_2_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SPINEL_LVL_2)

func _on_spinel_level_3_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SPINEL_LVL_3)

func _on_spinel_level_4_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SPINEL_LVL_4)

func _on_spinel_level_5_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.SPINEL_LVL_5)

# LARIMAR
# ------
func _on_larimar_level_2_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.LARIMAR_LVL_2)

func _on_larimar_level_3_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.LARIMAR_LVL_3)

func _on_larimar_level_4_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.LARIMAR_LVL_4)

func _on_larimar_level_5_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.LARIMAR_LVL_5)

# KUNZITE
# ------
func _on_kunzite_level_2_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.KUNZITE_LVL_2)

func _on_kunzite_level_3_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.KUNZITE_LVL_3)

func _on_kunzite_level_4_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.KUNZITE_LVL_4)

func _on_kunzite_level_5_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.KUNZITE_LVL_5)


# BISMUTH
# -------
func _on_bismuth_level_2_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BISMUTH_LVL_2)

func _on_bismuth_level_3_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BISMUTH_LVL_3)

func _on_bismuth_level_4_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BISMUTH_LVL_4)

func _on_bismuth_level_5_button_pressed():
    CONNECTED_MAIN_HUB.handle_built_tower_compound_upgrade(TowerConstants.TowerIDs.BISMUTH_LVL_5)