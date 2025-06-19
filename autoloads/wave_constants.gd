extends Node

const TOTAL_WAVES: int = 20

enum WaveProperties {
	CREEP_ID,
	CREEP_SPEED,
	CREEP_HEALTH,
	WAVE_SIZE,
	SPAWN_COOLDOWN_TIME,
	POINTS_FOR_DEATH
}

const WAVE_1: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.TREE,
	WaveProperties.CREEP_SPEED: 5,
	WaveProperties.CREEP_HEALTH: 10,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_2: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 6,
	WaveProperties.CREEP_HEALTH: 14,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.3,
	WaveProperties.POINTS_FOR_DEATH: 2
}

const WAVE_3: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 7,
	WaveProperties.CREEP_HEALTH: 20,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 4
}

const WAVE_4: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 30,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 8
}

const WAVE_5: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 6,
	WaveProperties.CREEP_HEALTH: 45,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 12
}

const WAVE_6: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 10,
	WaveProperties.WAVE_SIZE: 20,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.3,
	WaveProperties.POINTS_FOR_DEATH: 15
}

const WAVE_7: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 40,
	WaveProperties.WAVE_SIZE: 30,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 16
}

const WAVE_8: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 60,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 17
}

const WAVE_9: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 75,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 20
}

const WAVE_10: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 80,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 21
}

const WAVE_11: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 100,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 24
}

const WAVE_12: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 120,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 30
}

const WAVE_13: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 14,
	WaveProperties.CREEP_HEALTH: 30,
	WaveProperties.WAVE_SIZE: 40,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 10
}

const WAVE_14: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 20000,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_15: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 40000,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_16: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 60000,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_17: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 120000,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_18: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 200000,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_19: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 400000,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_20: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 600000,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}



const WAVES = [
	WAVE_1,
	WAVE_2,
	WAVE_3,
	WAVE_4,
	WAVE_5,
	WAVE_6,
	WAVE_7,
	WAVE_8,
	WAVE_9,
	WAVE_10,
	WAVE_11,
	WAVE_12,
	WAVE_13,
	WAVE_14,
	WAVE_15,
	WAVE_16,
	WAVE_17,
	WAVE_18,
	WAVE_19,
	WAVE_20
]
