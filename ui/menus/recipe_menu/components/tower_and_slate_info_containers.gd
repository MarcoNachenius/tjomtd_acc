extends VBoxContainer
class_name TowerAndSlateInfoContainers

@export var BUILDABLE_TOWER_INFO_CONTAINER: BuildableTowerInfoContainer
@export var UPGRADE_TOWER_INFO_CONTAINER: UpgradeTowerInfoContainer


## Displays only the buildable tower info container.
func show_buildable_tower_info_container() -> void:
    BUILDABLE_TOWER_INFO_CONTAINER.visible = true
    UPGRADE_TOWER_INFO_CONTAINER.visible = false

## Displays only the upgrade tower info container.
func show_upgrade_tower_info_container() -> void:
    UPGRADE_TOWER_INFO_CONTAINER.visible = true
    BUILDABLE_TOWER_INFO_CONTAINER.visible = false