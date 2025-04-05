extends Node

enum WaveProperties {
	CREEP_ID,
	CREEP_SPEED,
	CREEP_HEALTH,
	WAVE_SIZE,
	SPAWN_COOLDOWN_TIME
}

const WAVE_1: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 3,
	WaveProperties.CREEP_HEALTH: 100,
	WaveProperties.WAVE_SIZE: 1,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.5
}

const WAVE_2: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.DEMON,
	WaveProperties.CREEP_SPEED: 15,
	WaveProperties.CREEP_HEALTH: 12,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.3
}

const WAVES = [
	WAVE_1,
	WAVE_2
]
