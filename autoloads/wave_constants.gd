extends Node

const TOTAL_WAVES: int = 50

enum WaveProperties {
	CREEP_ID,
	CREEP_SPEED,
	CREEP_HEALTH,
	WAVE_SIZE,
	SPAWN_COOLDOWN_TIME,
	POINTS_FOR_DEATH
}

const FINAL_BOSS_WAVE: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.ROBOT,
	WaveProperties.CREEP_SPEED: 5,
	WaveProperties.CREEP_HEALTH: 10,
	WaveProperties.WAVE_SIZE: 1,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_1: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.TREE,
	WaveProperties.CREEP_SPEED: 4,
	WaveProperties.CREEP_HEALTH: 10,
	WaveProperties.WAVE_SIZE: 10,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.2,
	WaveProperties.POINTS_FOR_DEATH: 1
}

const WAVE_2: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 4,
	WaveProperties.CREEP_HEALTH: 15,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.1,
	WaveProperties.POINTS_FOR_DEATH: 2
}

const WAVE_3: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 5,
	WaveProperties.CREEP_HEALTH: 22,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 1.0,
	WaveProperties.POINTS_FOR_DEATH: 3
}


const WAVE_4: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 5,
	WaveProperties.CREEP_HEALTH: 130,
	WaveProperties.WAVE_SIZE: 54,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 4
}

const WAVE_5: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 6,
	WaveProperties.CREEP_HEALTH: 150,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 5
}

const WAVE_6: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 6,
	WaveProperties.CREEP_HEALTH: 170,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 6
}

const WAVE_7: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 6,
	WaveProperties.CREEP_HEALTH: 190,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 7
}

const WAVE_8: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 6,
	WaveProperties.CREEP_HEALTH: 210,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 8
}

const WAVE_9: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 6,
	WaveProperties.CREEP_HEALTH: 230,
	WaveProperties.WAVE_SIZE: 59,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 9
}

const WAVE_10: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 7,
	WaveProperties.CREEP_HEALTH: 250,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 10
}

const WAVE_11: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 7,
	WaveProperties.CREEP_HEALTH: 270,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 11
}

const WAVE_12: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 7,
	WaveProperties.CREEP_HEALTH: 290,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 12
}

const WAVE_13: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 7,
	WaveProperties.CREEP_HEALTH: 310,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 13
}

const WAVE_14: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 7,
	WaveProperties.CREEP_HEALTH: 330,
	WaveProperties.WAVE_SIZE: 64,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 14
}

const WAVE_15: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 350,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 15
}

const WAVE_16: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 370,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 16
}

const WAVE_17: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 390,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 17
}

const WAVE_18: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 410,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 18
}

const WAVE_19: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 430,
	WaveProperties.WAVE_SIZE: 69,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 19
}

const WAVE_20: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.ROBOT,
	WaveProperties.CREEP_SPEED: 8,
	WaveProperties.CREEP_HEALTH: 2000,
	WaveProperties.WAVE_SIZE: 1,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 200
}

const WAVE_21: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 470,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 21
}

const WAVE_22: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 490,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 22
}

const WAVE_23: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 510,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 23
}

const WAVE_24: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 530,
	WaveProperties.WAVE_SIZE: 74,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 24
}

const WAVE_25: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 10,
	WaveProperties.CREEP_HEALTH: 550,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 25
}

const WAVE_26: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 10,
	WaveProperties.CREEP_HEALTH: 570,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 26
}

const WAVE_27: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 10,
	WaveProperties.CREEP_HEALTH: 590,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 27
}

const WAVE_28: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 10,
	WaveProperties.CREEP_HEALTH: 610,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 28
}

const WAVE_29: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 10,
	WaveProperties.CREEP_HEALTH: 630,
	WaveProperties.WAVE_SIZE: 79,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 29
}

const WAVE_30: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 11,
	WaveProperties.CREEP_HEALTH: 650,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 30
}

const WAVE_31: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 11,
	WaveProperties.CREEP_HEALTH: 670,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 31
}

const WAVE_32: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 11,
	WaveProperties.CREEP_HEALTH: 690,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 32
}

const WAVE_33: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 11,
	WaveProperties.CREEP_HEALTH: 710,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 33
}

const WAVE_34: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 11,
	WaveProperties.CREEP_HEALTH: 730,
	WaveProperties.WAVE_SIZE: 84,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 34
}

const WAVE_35: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 750,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 35
}

const WAVE_36: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 770,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 36
}

const WAVE_37: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 790,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 37
}

const WAVE_38: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 810,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 38
}

const WAVE_39: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 12,
	WaveProperties.CREEP_HEALTH: 830,
	WaveProperties.WAVE_SIZE: 89,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 39
}

const WAVE_40: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.ROBOT,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 4000,
	WaveProperties.WAVE_SIZE: 1,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 300
}

const WAVE_41: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 13,
	WaveProperties.CREEP_HEALTH: 870,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 41
}

const WAVE_42: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 13,
	WaveProperties.CREEP_HEALTH: 890,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 42
}

const WAVE_43: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 13,
	WaveProperties.CREEP_HEALTH: 910,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 43
}

const WAVE_44: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 13,
	WaveProperties.CREEP_HEALTH: 930,
	WaveProperties.WAVE_SIZE: 94,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 44
}

const WAVE_45: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.PUMPKIN,
	WaveProperties.CREEP_SPEED: 14,
	WaveProperties.CREEP_HEALTH: 950,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 45
}

const WAVE_46: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.HUMAN,
	WaveProperties.CREEP_SPEED: 14,
	WaveProperties.CREEP_HEALTH: 970,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 46
}

const WAVE_47: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.RED_SPIDER,
	WaveProperties.CREEP_SPEED: 14,
	WaveProperties.CREEP_HEALTH: 990,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 47
}

const WAVE_48: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.BLUE_SPIDER,
	WaveProperties.CREEP_SPEED: 14,
	WaveProperties.CREEP_HEALTH: 1010,
	WaveProperties.WAVE_SIZE: 12,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 48
}

const WAVE_49: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.CENTIPEDE,
	WaveProperties.CREEP_SPEED: 14,
	WaveProperties.CREEP_HEALTH: 1030,
	WaveProperties.WAVE_SIZE: 99,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.2,
	WaveProperties.POINTS_FOR_DEATH: 49
}

const WAVE_50: Dictionary = {
	WaveProperties.CREEP_ID: CreepConstants.CreepIDs.ROBOT,
	WaveProperties.CREEP_SPEED: 9,
	WaveProperties.CREEP_HEALTH: 4000,
	WaveProperties.WAVE_SIZE: 1,
	WaveProperties.SPAWN_COOLDOWN_TIME: 0.9,
	WaveProperties.POINTS_FOR_DEATH: 300
}

const WAVES: Array = [
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
WAVE_20,
WAVE_21,
WAVE_22,
WAVE_23,
WAVE_24,
WAVE_25,
WAVE_26,
WAVE_27,
WAVE_28,
WAVE_29,
WAVE_30,
WAVE_31,
WAVE_32,
WAVE_33,
WAVE_34,
WAVE_35,
WAVE_36,
WAVE_37,
WAVE_38,
WAVE_39,
WAVE_40,
WAVE_41,
WAVE_42,
WAVE_43,
WAVE_44,
WAVE_45,
WAVE_46,
WAVE_47,
WAVE_48,
WAVE_49,
WAVE_50
]