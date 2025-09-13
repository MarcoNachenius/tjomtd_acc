extends ScrollContainer
class_name TowerAndSlateScrollContainer

@export var BUILDABLE_TOWER_BUTTONS: BuildableTowerButtonsVBox
@export var UPGRADE_TOWER_BUTTONS: UpgradeTowerButtonsVBox
@export var SLATE_BUTTONS: SlateButtonVbox


## Displays only the buildable tower buttons scroll container.
## Hides upgrade tower buttons and slate buttons.
func show_buildable_tower_buttons() -> void:
    BUILDABLE_TOWER_BUTTONS.visible = true
    UPGRADE_TOWER_BUTTONS.visible = false
    SLATE_BUTTONS.visible = false


## Displays only the upgrade tower buttons scroll container.
## Hides buildable tower buttons and slate buttons.
func show_upgrade_tower_buttons() -> void:
    UPGRADE_TOWER_BUTTONS.visible = true
    BUILDABLE_TOWER_BUTTONS.visible = false
    SLATE_BUTTONS.visible = false


## Displays only the slate buttons scroll container.
## Hides buildable tower buttons and upgrade tower buttons.
func show_slate_buttons() -> void:
    SLATE_BUTTONS.visible = true
    BUILDABLE_TOWER_BUTTONS.visible = false
    UPGRADE_TOWER_BUTTONS.visible = false
