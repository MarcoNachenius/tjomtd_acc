extends Node
class_name TowerAuraManager

# SINGLETON VARS
# ==============
var CONNECTED_TOWER: Tower
var __active_damage_auras: Dictionary[TowerDamageAura, int] # Value = Damage buff amount

func _init(referenceTower: Tower) -> void:
	CONNECTED_TOWER = referenceTower

func _ready() -> void:
	_connect_detection_area_signals()

# PRIVATE METHODS
func _connect_detection_area_signals() -> void:
	assert(CONNECTED_TOWER, "Tower reference is not set in TowerAuraManager")
	assert(CONNECTED_TOWER.DETECTION_AREA, "Detection area is not set in TowerAuraManager")
	assert(CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER, "Tower has no primary projectile spawner assigned")

	# Damage Aura
	_connect_damage_aura_signals()

# SIGNALS METHODS
func _on_damage_aura_entered(damageAura: TowerDamageAura) -> void:
	# Calculate damage buff amount
	var damage_buff_amount: int = CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.damage_factor_amount(damageAura.DAMAGE_INCREASE_FACTOR)

	# Do nothing if damage buff amount is 0
	if damage_buff_amount == 0:
		return
	
	# Add damage buff amount to tower's primary projectile spawner
	CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.increase_damage(damage_buff_amount)

	# Track damage auras and the amount of damage that they add to
	# tower's primary projectile spawner.
	__active_damage_auras[damageAura] = damage_buff_amount


func _on_damage_aura_exited(damageAura: TowerDamageAura) -> void: # WIP
	# Tracking of damage aura may have been removed at some stage.
	# For instance, the tower may have a max damage aura cap and only wants auras that are the most preferential to it.
	if !__active_damage_auras.keys().has(damageAura):
		return

	# Retrieve damage buff amount
	var damage_buff_amount: int = __active_damage_auras[damageAura]

	# Decrease tower's primary projectile spawner damage by retrieved buff amount
	CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.decrease_damage(damage_buff_amount)

	# End tracking of damage aura
	__active_damage_auras.erase(damageAura)

# HELPER METHODS
func _connect_damage_aura_signals() -> void:
	# Do not connect signals for damage auras if projectile spawner does not allow damage buffs.
	if !CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.ALLOW_DAMAGE_BUFFS:
		return
	
	CONNECTED_TOWER.DETECTION_AREA.damage_aura_entered.connect(_on_damage_aura_entered)
	CONNECTED_TOWER.DETECTION_AREA.damage_aura_exited.connect(_on_damage_aura_exited)
