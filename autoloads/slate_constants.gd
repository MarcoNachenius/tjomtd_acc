extends Node

enum SlateIDs {
    # ===== Hold slates =====
    HOLD_SLATE_LVL_1,
    HOLD_SLATE_LVL_2,
    HOLD_SLATE_LVL_3,

    # ===== Slow slates =====
    SLOW_SLATE_LVL_1,
    SLOW_SLATE_LVL_2,
    SLOW_SLATE_LVL_3,

    # ===== Burn slates =====
    BURN_SLATE_LVL_1,
    BURN_SLATE_LVL_2,
    BURN_SLATE_LVL_3,

    # ===== Damage slates =====
    DAMAGE_SLATE_LVL_1,
    DAMAGE_SLATE_LVL_2,
    DAMAGE_SLATE_LVL_3,

    # ===== Range slates =====
    RANGE_SLATE_LVL_1,
    RANGE_SLATE_LVL_2,
    RANGE_SLATE_LVL_3,

    # ===== Speed slates =====
    SPEED_SLATE_LVL_1,
    SPEED_SLATE_LVL_2,
    SPEED_SLATE_LVL_3,
}


var SLATE_LOADS: Dictionary[SlateIDs, PackedScene] = {
    # ===== Hold slates =====
    SlateIDs.HOLD_SLATE_LVL_1: load("res://slates/hold_slates/hold_slate_lvl_1/hold_slate_lvl_1.tscn"),
    SlateIDs.HOLD_SLATE_LVL_2: load("res://slates/hold_slates/hold_slate_lvl_2/hold_slate_lvl_2.tscn"),
    SlateIDs.HOLD_SLATE_LVL_3: load("res://slates/hold_slates/hold_slate_lvl_3/hold_slate_lvl_3.tscn"),

    # ===== Slow slates =====
    SlateIDs.SLOW_SLATE_LVL_1: load("res://slates/slow_slates/slow_slate_lvl_1/slow_slate_lvl_1.tscn"),
    SlateIDs.SLOW_SLATE_LVL_2: load("res://slates/slow_slates/slow_slate_lvl_2/slow_slate_lvl_2.tscn"),
    SlateIDs.SLOW_SLATE_LVL_3: load("res://slates/slow_slates/slow_slate_lvl_3/slow_slate_lvl_3.tscn"),

    # ===== Burn slates =====
    #SlateIDs.BURN_SLATE_LVL_1: load(""),
    #SlateIDs.BURN_SLATE_LVL_2: load(""),
    #SlateIDs.BURN_SLATE_LVL_3: load(""),

    # ===== Damage slates =====
    SlateIDs.DAMAGE_SLATE_LVL_1: load("res://slates/damage_slates/damage_slate_lvl_1/damage_slate_lvl_1.tscn"),
    SlateIDs.DAMAGE_SLATE_LVL_2: load("res://slates/damage_slates/damage_slate_lvl_2/damage_slate_lvl_2.tscn"),
    SlateIDs.DAMAGE_SLATE_LVL_3: load("res://slates/damage_slates/damage_slate_lvl_3/damage_slate_lvl_3.tscn"),

    # ===== Range slates =====
    #SlateIDs.RANGE_SLATE_LVL_1: load(""),
    #SlateIDs.RANGE_SLATE_LVL_2: load(""),
    #SlateIDs.RANGE_SLATE_LVL_3: load(""),

    # ===== Speed slates =====
    #SlateIDs.SPEED_SLATE_LVL_1: load(""),
    #SlateIDs.SPEED_SLATE_LVL_2: load(""),
    #SlateIDs.SPEED_SLATE_LVL_3: load(""),
}


var REQUIRES_TOWERS: Dictionary[SlateIDs, Dictionary] = {
    # ===== Hold slates =====
    SlateIDs.HOLD_SLATE_LVL_1: {
        TowerConstants.TowerIDs.LARIMAR_LVL_1: 1,
        TowerConstants.TowerIDs.LARIMAR_LVL_2: 1,
        TowerConstants.TowerIDs.SUNSTONE_LVL_3: 1,
    },
    SlateIDs.HOLD_SLATE_LVL_2: {
        TowerConstants.TowerIDs.LARIMAR_LVL_2: 1,
        TowerConstants.TowerIDs.LARIMAR_LVL_3: 1,
        TowerConstants.TowerIDs.SUNSTONE_LVL_4: 1,
    },
    SlateIDs.HOLD_SLATE_LVL_3: {
        TowerConstants.TowerIDs.LARIMAR_LVL_4: 1,
        TowerConstants.TowerIDs.SUNSTONE_LVL_5: 1,
    },

    # ===== Slow slates =====
    SlateIDs.SLOW_SLATE_LVL_1: {
        TowerConstants.TowerIDs.SUNSTONE_LVL_1: 1,
        TowerConstants.TowerIDs.SUNSTONE_LVL_2: 1,
        TowerConstants.TowerIDs.BISMUTH_LVL_3: 1,
    },
    SlateIDs.SLOW_SLATE_LVL_2: {
        TowerConstants.TowerIDs.SUNSTONE_LVL_3: 1,
        TowerConstants.TowerIDs.BISMUTH_LVL_4: 1,
    },
    SlateIDs.SLOW_SLATE_LVL_3: {
        TowerConstants.TowerIDs.SUNSTONE_LVL_2: 1,
        TowerConstants.TowerIDs.SUNSTONE_LVL_3: 1,
        TowerConstants.TowerIDs.BISMUTH_LVL_4: 1,
    },

    # ===== Burn slates =====
    SlateIDs.BURN_SLATE_LVL_1: {},
    SlateIDs.BURN_SLATE_LVL_2: {},
    SlateIDs.BURN_SLATE_LVL_3: {},

    # ===== Damage slates =====
    SlateIDs.DAMAGE_SLATE_LVL_1: {
        TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: 1,
        TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2: 1,
        TowerConstants.TowerIDs.SPINEL_LVL_3: 1,
    },
    SlateIDs.DAMAGE_SLATE_LVL_2: {
        TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3: 1,
        TowerConstants.TowerIDs.SPINEL_LVL_4: 1,
    },
    SlateIDs.DAMAGE_SLATE_LVL_3: {
        TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3: 1,
        TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4: 1,
        TowerConstants.TowerIDs.SPINEL_LVL_5: 1,
    },

    # ===== Range slates =====
    SlateIDs.RANGE_SLATE_LVL_1: {},
    SlateIDs.RANGE_SLATE_LVL_2: {},
    SlateIDs.RANGE_SLATE_LVL_3: {},
    
    # ===== Speed slates =====
    SlateIDs.SPEED_SLATE_LVL_1: {},
    SlateIDs.SPEED_SLATE_LVL_2: {},
    SlateIDs.SPEED_SLATE_LVL_3: {},
}

const TOWER_UPGRADES_INTO_SLATES: Dictionary[TowerConstants.TowerIDs, Array] = {
    # ===== Hold Slates and Slow Slates =====
    TowerConstants.TowerIDs.LARIMAR_LVL_1: [SlateIDs.HOLD_SLATE_LVL_1],
    TowerConstants.TowerIDs.LARIMAR_LVL_2: [SlateIDs.HOLD_SLATE_LVL_1, SlateIDs.HOLD_SLATE_LVL_2],
    TowerConstants.TowerIDs.SUNSTONE_LVL_3: [SlateIDs.HOLD_SLATE_LVL_1, SlateIDs.SLOW_SLATE_LVL_2, SlateIDs.SLOW_SLATE_LVL_3],
    TowerConstants.TowerIDs.LARIMAR_LVL_3: [SlateIDs.HOLD_SLATE_LVL_2],
    TowerConstants.TowerIDs.SUNSTONE_LVL_4: [SlateIDs.HOLD_SLATE_LVL_2],
    TowerConstants.TowerIDs.LARIMAR_LVL_4: [SlateIDs.HOLD_SLATE_LVL_3],
    TowerConstants.TowerIDs.SUNSTONE_LVL_5: [SlateIDs.HOLD_SLATE_LVL_3],
    TowerConstants.TowerIDs.SUNSTONE_LVL_1: [SlateIDs.SLOW_SLATE_LVL_1],
    TowerConstants.TowerIDs.SUNSTONE_LVL_2: [SlateIDs.SLOW_SLATE_LVL_1],
    TowerConstants.TowerIDs.BISMUTH_LVL_3: [SlateIDs.SLOW_SLATE_LVL_1],
    TowerConstants.TowerIDs.BISMUTH_LVL_4: [SlateIDs.SLOW_SLATE_LVL_2, SlateIDs.SLOW_SLATE_LVL_3],

    # ===== Damage slates and Range Slates =====
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_1: [SlateIDs.DAMAGE_SLATE_LVL_1],
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_2: [SlateIDs.DAMAGE_SLATE_LVL_1],
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_3: [SlateIDs.DAMAGE_SLATE_LVL_2, SlateIDs.DAMAGE_SLATE_LVL_3],
    TowerConstants.TowerIDs.BLACK_MARBLE_LVL_4: [SlateIDs.DAMAGE_SLATE_LVL_3],
    TowerConstants.TowerIDs.SPINEL_LVL_3: [SlateIDs.DAMAGE_SLATE_LVL_1],
    TowerConstants.TowerIDs.SPINEL_LVL_4: [SlateIDs.DAMAGE_SLATE_LVL_2],
    TowerConstants.TowerIDs.SPINEL_LVL_5: [SlateIDs.DAMAGE_SLATE_LVL_3],
}
