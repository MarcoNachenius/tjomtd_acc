extends VBoxContainer
class_name TowerAndSlateInfoContainers

@export var BUILDABLE_TOWER_INFO_CONTAINER: BuildableTowerInfoContainer
@export var UPGRADE_TOWER_INFO_CONTAINER: UpgradeTowerInfoContainer
@export var SLATE_INFO_CONTAINER: SlateInfoContainer


## Displays only the buildable tower info container.
func show_buildable_tower_info_container() -> void:
    BUILDABLE_TOWER_INFO_CONTAINER.visible = true
    UPGRADE_TOWER_INFO_CONTAINER.visible = false
    SLATE_INFO_CONTAINER.visible = false

## Displays only the upgrade tower info container.
func show_upgrade_tower_info_container() -> void:
    UPGRADE_TOWER_INFO_CONTAINER.visible = true
    BUILDABLE_TOWER_INFO_CONTAINER.visible = false
    SLATE_INFO_CONTAINER.visible = false

## Displays only the slate info container.
func show_slate_info_container() -> void:
    SLATE_INFO_CONTAINER.visible = true
    BUILDABLE_TOWER_INFO_CONTAINER.visible = false
    UPGRADE_TOWER_INFO_CONTAINER.visible = false