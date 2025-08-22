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
    SlateIDs.HOLD_SLATE_LVL_1: load("res://slates/hold_slates/hold_slate_lvl_1/hold_slate_lvl_1.tscn"),
    #SlateIDs.HOLD_SLATE_LVL_2: load(""),
    #SlateIDs.HOLD_SLATE_LVL_3: load(""),
    # ===== Slow slates =====
    #SlateIDs.SLOW_SLATE_LVL_1: load(""),
    #SlateIDs.SLOW_SLATE_LVL_2: load(""),
    #SlateIDs.SLOW_SLATE_LVL_3: load(""),
    # ===== Burn slates =====
    #SlateIDs.BURN_SLATE_LVL_1: load(""),
    #SlateIDs.BURN_SLATE_LVL_2: load(""),
    #SlateIDs.BURN_SLATE_LVL_3: load(""),
    # ===== Damage slates =====
    #SlateIDs.DAMAGE_SLATE_LVL_1: load(""),
    #SlateIDs.DAMAGE_SLATE_LVL_2: load(""),
    #SlateIDs.DAMAGE_SLATE_LVL_3: load(""),
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
    SlateIDs.HOLD_SLATE_LVL_1: {},
    SlateIDs.HOLD_SLATE_LVL_2: {},
    SlateIDs.HOLD_SLATE_LVL_3: {},
    # ===== Slow slates =====
    SlateIDs.SLOW_SLATE_LVL_1: {},
    SlateIDs.SLOW_SLATE_LVL_2: {},
    SlateIDs.SLOW_SLATE_LVL_3: {},
    # ===== Burn slates =====
    SlateIDs.BURN_SLATE_LVL_1: {},
    SlateIDs.BURN_SLATE_LVL_2: {},
    SlateIDs.BURN_SLATE_LVL_3: {},
    # ===== Damage slates =====
    SlateIDs.DAMAGE_SLATE_LVL_1: {},
    SlateIDs.DAMAGE_SLATE_LVL_2: {},
    SlateIDs.DAMAGE_SLATE_LVL_3: {},
    # ===== Range slates =====
    SlateIDs.RANGE_SLATE_LVL_1: {},
    SlateIDs.RANGE_SLATE_LVL_2: {},
    SlateIDs.RANGE_SLATE_LVL_3: {},
    # ===== Speed slates =====
    SlateIDs.SPEED_SLATE_LVL_1: {},
    SlateIDs.SPEED_SLATE_LVL_2: {},
    SlateIDs.SPEED_SLATE_LVL_3: {},
}