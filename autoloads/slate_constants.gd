extends Node

enum SlateIDs {
    HOLD_SLATE_LVL_1,
    SLOW_SLATE_LVL_1,
}

var SLATE_LOADS: Dictionary[SlateIDs, PackedScene] = {
    SlateIDs.HOLD_SLATE_LVL_1: load("res://slates/hold_slates/hold_slate_lvl_1/hold_slate_lvl_1.tscn"),
}