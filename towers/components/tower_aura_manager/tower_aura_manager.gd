extends Node
class_name TowerAuraManager

# SINGLETON VARS
# ==============
var CONNECTED_TOWER: Tower

# PRIVATE VARS
# ============
var __active_damage_auras: Dictionary[TowerDamageAura, int] # Value = Damage buff amount
var __active_range_auras: Dictionary[TowerRangeAura, int] # Value = Range buff amount
var __active_speed_auras: Dictionary[TowerSpeedAura, float] # Value = Speed buff amount

# INHERITED METHODS
# =================
func _init(referenceTower: Tower) -> void:
	CONNECTED_TOWER = referenceTower

func _ready() -> void:
	_connect_detection_area_signals()

# PRIVATE METHODS
# ===============
func _connect_detection_area_signals() -> void:
	assert(CONNECTED_TOWER, "Tower reference is not set in TowerAuraManager")
	assert(CONNECTED_TOWER.DETECTION_AREA, "Detection area is not set in TowerAuraManager")
	assert(CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER, "Tower has no primary projectile spawner assigned")

	# Damage Aura
	_connect_damage_aura_signals()
	# Range Aura
	_connect_range_aura_signals()
	# Speed Aura
	_connect_speed_aura_signals()

# SIGNAL METHODS
# ==============
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


func _on_damage_aura_exited(damageAura: TowerDamageAura) -> void:
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


func _on_range_aura_entered(rangeAura: TowerRangeAura) -> void:
	# Calculate range buff amount
	var range_buff_amount: int = CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.range_factor_amount(rangeAura.RANGE_INCREASE_FACTOR)

	# Do nothing if range buff amount is 0
	if range_buff_amount == 0:
		return
	
	# Add range buff amount to tower's primary projectile spawner
	CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.increase_range(range_buff_amount)

	# Track range auras and the amount of range that they add to
	# tower's primary projectile spawner.
	__active_range_auras[rangeAura] = range_buff_amount


func _on_range_aura_exited(rangeAura: TowerRangeAura) -> void:
	# Tracking of range aura may have been removed at some stage.
	# For instance, the tower may have a max range aura cap and only wants auras that are the most preferential to it.
	if !__active_range_auras.keys().has(rangeAura):
		return

	# Retrieve range buff amount
	var range_buff_amount: int = __active_range_auras[rangeAura]

	# Decrease tower's primary projectile spawner range by retrieved buff amount
	CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.decrease_range(range_buff_amount)

	# End tracking of range aura
	__active_range_auras.erase(rangeAura)


func _on_speed_aura_entered(speedAura: TowerSpeedAura) -> void:
	# Calculate speed buff amount
	var speed_buff_amount: float = CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.speed_factor_amount(speedAura.SPEED_INCREASE_FACTOR)

	# Do nothing if speed buff amount is 0 or lower
	if speed_buff_amount <= 0.00:
		return
	
	# Add speed buff amount to tower's primary projectile spawner
	CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.increase_speed(speed_buff_amount)

	# Track speed auras and the amount of speed that they add to
	# tower's primary projectile spawner.
	__active_speed_auras[speedAura] = speed_buff_amount


func _on_speed_aura_exited(speedAura: TowerSpeedAura) -> void:
	# Tracking of speed aura may have been removed at some stage.
	# For instance, the tower may have a max speed aura cap and only wants auras that are the most preferential to it.
	if !__active_speed_auras.keys().has(speedAura):
		return

	# Retrieve speed buff amount
	var speed_buff_amount: float = __active_speed_auras[speedAura]

	# Decrease tower's primary projectile spawner speed by retrieved buff amount
	CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.decrease_speed(speed_buff_amount)

	# End tracking of speed aura
	__active_speed_auras.erase(speedAura)


# HELPER METHODS
# ==============
func _connect_damage_aura_signals() -> void:
	# Do not connect any signals for damage auras if projectile spawner does not allow damage buffs.
	if !CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.ALLOW_DAMAGE_BUFFS:
		return
	
	CONNECTED_TOWER.DETECTION_AREA.damage_aura_entered.connect(_on_damage_aura_entered)
	CONNECTED_TOWER.DETECTION_AREA.damage_aura_exited.connect(_on_damage_aura_exited)

func _connect_range_aura_signals() -> void:
	# Do not connect any signals for range auras if projectile spawner does not allow range buffs.
	if !CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.ALLOW_RANGE_BUFFS:
		return
	
	CONNECTED_TOWER.DETECTION_AREA.range_aura_entered.connect(_on_range_aura_entered)
	CONNECTED_TOWER.DETECTION_AREA.range_aura_exited.connect(_on_range_aura_exited)

func _connect_speed_aura_signals() -> void:
	# Do not connect any signals for speed auras if projectile spawner does not allow speed buffs.
	if !CONNECTED_TOWER.PRIMARY_PROJECTILE_SPAWNER.ALLOW_SPEED_BUFFS:
		return
	
	CONNECTED_TOWER.DETECTION_AREA.speed_aura_entered.connect(_on_speed_aura_entered)
	CONNECTED_TOWER.DETECTION_AREA.speed_aura_exited.connect(_on_speed_aura_exited)
