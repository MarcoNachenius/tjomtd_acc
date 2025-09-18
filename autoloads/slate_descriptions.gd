extends Node

enum SlateStats {
    RANGE
}

const SLATE_NAMES: Dictionary[SlateConstants.SlateIDs, String] = {
    # ===== Hold slates =====
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_1: "Hold Slate Level 1",
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_2: "Hold Slate Level 2",
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_3: "Hold Slate Level 3",
    # ===== Slow slates =====
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_1: "Slow Slate Level 1",
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_2: "Slow Slate Level 2",
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_3: "Slow Slate Level 3",
    # ===== Burn slates =====
    SlateConstants.SlateIDs.BURN_SLATE_LVL_1: "Burn Slate Level 1",
    SlateConstants.SlateIDs.BURN_SLATE_LVL_2: "Burn Slate Level 2",
    SlateConstants.SlateIDs.BURN_SLATE_LVL_3: "Burn Slate Level 3",
    # ===== Damage slates =====
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1: "Damage Slate Level 1",
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_2: "Damage Slate Level 2",
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_3: "Damage Slate Level 3",
    # ===== Range slates =====
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_1: "Range Slate Level 1",
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_2: "Range Slate Level 2",
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_3: "Range Slate Level 3",
    # ===== Speed slates =====
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_1: "Speed Slate Level 1",
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_2: "Speed Slate Level 2",
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_3: "Speed Slate Level 3",
}

const SLATE_ID_TO_DESCRIPTION_TEXT: Dictionary[SlateConstants.SlateIDs, String] = {
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_1: "Description text for HOLD_SLATE_LVL_1",
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_2: "Description text for HOLD_SLATE_LVL_2",
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_3: "Description text for HOLD_SLATE_LVL_3",
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_1: "Description text for SLOW_SLATE_LVL_1",
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_2: "Description text for SLOW_SLATE_LVL_2",
    SlateConstants.SlateIDs.SLOW_SLATE_LVL_3: "Description text for SLOW_SLATE_LVL_3",
    SlateConstants.SlateIDs.BURN_SLATE_LVL_1: "Description text for BURN_SLATE_LVL_1",
    SlateConstants.SlateIDs.BURN_SLATE_LVL_2: "Description text for BURN_SLATE_LVL_2",
    SlateConstants.SlateIDs.BURN_SLATE_LVL_3: "Description text for BURN_SLATE_LVL_3",
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_1: "Description text for DAMAGE_SLATE_LVL_1",
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_2: "Description text for DAMAGE_SLATE_LVL_2",
    SlateConstants.SlateIDs.DAMAGE_SLATE_LVL_3: "Description text for DAMAGE_SLATE_LVL_3",
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_1: "Description text for RANGE_SLATE_LVL_1",
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_2: "Description text for RANGE_SLATE_LVL_2",
    SlateConstants.SlateIDs.RANGE_SLATE_LVL_3: "Description text for RANGE_SLATE_LVL_3",
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_1: "Description text for SPEED_SLATE_LVL_1",
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_2: "Description text for SPEED_SLATE_LVL_2",
    SlateConstants.SlateIDs.SPEED_SLATE_LVL_3: "Description text for SPEED_SLATE_LVL_3",
}

const SLATE_ID_TO_STATS: Dictionary[SlateConstants.SlateIDs, Dictionary] = {
    SlateConstants.SlateIDs.HOLD_SLATE_LVL_1: {
        SlateStats.RANGE: 200
    }
}