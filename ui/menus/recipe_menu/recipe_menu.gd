extends CanvasLayer
class_name RecipeMenu

# ==================================================
#                  EXPORT VARS
# ==================================================
@export var RETURN_TO_MENU_BUTTON: Button
@export var RECIPE_TYPE_BUTTON_VBOX: RecipeTypeButtonVbox
@export var TOWER_AND_SLATE_BUTTONS: TowerAndSlateScrollContainer
@export var TOWER_AND_SLATE_INFO_CONTAINERS: TowerAndSlateInfoContainers


# ==================================================
#                     PRIVATE VARS
# ==================================================
# Set arbitrary last selected towers and slates on ready
@onready var __last_selected_buildable_tower_id: TowerConstants.TowerIDs = TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1
@onready var __last_selected_upgrade_tower_id: TowerConstants.TowerIDs = TowerConstants.TowerIDs.TOMBSTONE_LVL_1
@onready var __last_selected_slate_id: SlateConstants.SlateIDs = SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1


# ==================================================
#                  INHERITED METHODS
# ==================================================
func _ready() -> void:
    _connect_tower_and_slate_button_signals()
    _connect_recipe_type_button_signals()
    _connect_info_container_button_list_signals()

    # Set default starting point
    _on_show_buildable_tower_buttons_pressed()


# ==================================================
#                  SIGNAL CONNECTORS
# ==================================================
func _connect_tower_and_slate_button_signals() -> void:
    assert(TOWER_AND_SLATE_BUTTONS, "Tower and Slate button container has not been assigned as an export")
    TOWER_AND_SLATE_BUTTONS.SLATE_BUTTONS.slate_button_pressed.connect(_on_slate_button_pressed)
    TOWER_AND_SLATE_BUTTONS.BUILDABLE_TOWER_BUTTONS.buildable_tower_button_pressed.connect(_on_buildable_tower_button_pressed)
    TOWER_AND_SLATE_BUTTONS.UPGRADE_TOWER_BUTTONS.upgrade_tower_button_pressed.connect(_on_upgrade_tower_button_pressed)


func _connect_recipe_type_button_signals() -> void:
    assert(RECIPE_TYPE_BUTTON_VBOX, "Recipe type button vbox has not been assigned as export")
    RECIPE_TYPE_BUTTON_VBOX.BUILDABLE_TOWERS_BUTTON.pressed.connect(_on_show_buildable_tower_buttons_pressed)
    RECIPE_TYPE_BUTTON_VBOX.UPGRADE_TOWERS_BUTTON.pressed.connect(_on_show_upgrade_tower_buttons_pressed)
    RECIPE_TYPE_BUTTON_VBOX.SLATE_BUTTON.pressed.connect(_on_show_slate_buttons_pressed)

## WIP
func _connect_info_container_button_list_signals() -> void:
    # BUILDABLE TOWER INFO
    TOWER_AND_SLATE_INFO_CONTAINERS.BUILDABLE_TOWER_INFO_CONTAINER.UPGRADES_INTO_TOWER_BUTTONS.upgrade_tower_button_pressed.connect(_on_upgrade_tower_button_pressed)
    TOWER_AND_SLATE_INFO_CONTAINERS.BUILDABLE_TOWER_INFO_CONTAINER.UPGRADES_INTO_SLATES_BUTTONS.slate_button_pressed.connect(_on_slate_button_pressed)
    # UPGRADE TOWER INFO
    TOWER_AND_SLATE_INFO_CONTAINERS.UPGRADE_TOWER_INFO_CONTAINER.REQUIRES_BUILDABLE_TOWERS_BUTTONS.buildable_tower_button_pressed.connect(_on_buildable_tower_button_pressed)
    TOWER_AND_SLATE_INFO_CONTAINERS.UPGRADE_TOWER_INFO_CONTAINER.REQUIRES_UPGRADE_TOWERS_BUTTONS.upgrade_tower_button_pressed.connect(_on_upgrade_tower_button_pressed)
    TOWER_AND_SLATE_INFO_CONTAINERS.UPGRADE_TOWER_INFO_CONTAINER.UPGRADES_INTO_TOWER_BUTTONS.upgrade_tower_button_pressed.connect(_on_upgrade_tower_button_pressed)
    # SLATE INFO
    TOWER_AND_SLATE_INFO_CONTAINERS.SLATE_INFO_CONTAINER.REQUIRES_BUILDABLE_TOWERS_BUTTONS.buildable_tower_button_pressed.connect(_on_buildable_tower_button_pressed)
    TOWER_AND_SLATE_INFO_CONTAINERS.SLATE_INFO_CONTAINER.REQUIRES_UPGRADE_TOWERS_BUTTONS.upgrade_tower_button_pressed.connect(_on_upgrade_tower_button_pressed)


# ==================================================
#               TOWER AND SLATE BUTTONS
# ==================================================
func _on_buildable_tower_button_pressed(towerID: TowerConstants.TowerIDs) -> void:
    # Update last selected buildable tower
    __last_selected_buildable_tower_id = towerID

    # Show only buildable tower buttons
    TOWER_AND_SLATE_BUTTONS.BUILDABLE_TOWER_BUTTONS.visible = true
    TOWER_AND_SLATE_BUTTONS.UPGRADE_TOWER_BUTTONS.visible = false
    TOWER_AND_SLATE_BUTTONS.SLATE_BUTTONS.visible = false

    # Ensure only buildable tower buttons are visible in scroll bar
    TOWER_AND_SLATE_BUTTONS.show_buildable_tower_buttons()

    # Ensure only buildable tower information is visible
    TOWER_AND_SLATE_INFO_CONTAINERS.show_buildable_tower_info_container()

    # Load tower information to display container
    TOWER_AND_SLATE_INFO_CONTAINERS.BUILDABLE_TOWER_INFO_CONTAINER.display_tower_information(towerID)

    # Highlight 'Buildable Towers' button
    RECIPE_TYPE_BUTTON_VBOX.BUILDABLE_TOWERS_BUTTON.toggle_mode = true
    RECIPE_TYPE_BUTTON_VBOX.BUILDABLE_TOWERS_BUTTON.set_pressed_no_signal(true)
    # Ensure other buttons are no longer highlighted
    RECIPE_TYPE_BUTTON_VBOX.UPGRADE_TOWERS_BUTTON.toggle_mode = false
    RECIPE_TYPE_BUTTON_VBOX.UPGRADE_TOWERS_BUTTON.set_pressed_no_signal(false)
    RECIPE_TYPE_BUTTON_VBOX.SLATE_BUTTON.toggle_mode = false
    RECIPE_TYPE_BUTTON_VBOX.SLATE_BUTTON.set_pressed_no_signal(false)


# WIP
func _on_upgrade_tower_button_pressed(towerID: TowerConstants.TowerIDs) -> void:
    # Update last selected upgrade tower
    __last_selected_upgrade_tower_id = towerID

    # Show only upgrade tower buttons
    TOWER_AND_SLATE_BUTTONS.UPGRADE_TOWER_BUTTONS.visible = true
    TOWER_AND_SLATE_BUTTONS.BUILDABLE_TOWER_BUTTONS.visible = false
    TOWER_AND_SLATE_BUTTONS.SLATE_BUTTONS.visible = false

    # Ensure only upgrade tower buttons are visible in scroll bar
    TOWER_AND_SLATE_BUTTONS.show_upgrade_tower_buttons()

    # Ensure only upgrade tower information is visible
    TOWER_AND_SLATE_INFO_CONTAINERS.show_upgrade_tower_info_container()

    # Load tower information to display container
    TOWER_AND_SLATE_INFO_CONTAINERS.UPGRADE_TOWER_INFO_CONTAINER.display_tower_information(towerID)

    # Highlight 'Upgrade Towers' button
    RECIPE_TYPE_BUTTON_VBOX.UPGRADE_TOWERS_BUTTON.toggle_mode = true
    RECIPE_TYPE_BUTTON_VBOX.UPGRADE_TOWERS_BUTTON.set_pressed_no_signal(true)
    # Ensure other buttons are no longer highlighted
    RECIPE_TYPE_BUTTON_VBOX.BUILDABLE_TOWERS_BUTTON.toggle_mode = false
    RECIPE_TYPE_BUTTON_VBOX.BUILDABLE_TOWERS_BUTTON.set_pressed_no_signal(false)
    RECIPE_TYPE_BUTTON_VBOX.SLATE_BUTTON.toggle_mode = false
    RECIPE_TYPE_BUTTON_VBOX.SLATE_BUTTON.set_pressed_no_signal(false)

# WIP
func _on_slate_button_pressed(slateID: SlateConstants.SlateIDs) -> void:
    # Update last selected buildable tower
    __last_selected_slate_id = slateID

    # Show only slate buttons
    TOWER_AND_SLATE_BUTTONS.SLATE_BUTTONS.visible = true
    TOWER_AND_SLATE_BUTTONS.BUILDABLE_TOWER_BUTTONS.visible = false
    TOWER_AND_SLATE_BUTTONS.UPGRADE_TOWER_BUTTONS.visible = false

    # Ensure only slate buttons are visible in scroll bar
    TOWER_AND_SLATE_BUTTONS.show_slate_buttons()

    # Ensure only slate information is visible
    TOWER_AND_SLATE_INFO_CONTAINERS.show_slate_info_container()

    # Load tower information to display container
    TOWER_AND_SLATE_INFO_CONTAINERS.SLATE_INFO_CONTAINER.display_slate_information(slateID)

    # Highlight 'Slates' button
    RECIPE_TYPE_BUTTON_VBOX.SLATE_BUTTON.toggle_mode = true
    RECIPE_TYPE_BUTTON_VBOX.SLATE_BUTTON.set_pressed_no_signal(true)
    # Ensure other buttons are no longer highlighted
    RECIPE_TYPE_BUTTON_VBOX.BUILDABLE_TOWERS_BUTTON.toggle_mode = false
    RECIPE_TYPE_BUTTON_VBOX.BUILDABLE_TOWERS_BUTTON.set_pressed_no_signal(false)
    RECIPE_TYPE_BUTTON_VBOX.UPGRADE_TOWERS_BUTTON.toggle_mode = false
    RECIPE_TYPE_BUTTON_VBOX.UPGRADE_TOWERS_BUTTON.set_pressed_no_signal(false)


# ==================================================
#                RECIPE TYPE BUTTONS
# ==================================================
func _on_show_buildable_tower_buttons_pressed():
    _on_buildable_tower_button_pressed(__last_selected_buildable_tower_id)

func _on_show_upgrade_tower_buttons_pressed():
    _on_upgrade_tower_button_pressed(__last_selected_upgrade_tower_id)

func _on_show_slate_buttons_pressed():
    _on_slate_button_pressed(__last_selected_slate_id)