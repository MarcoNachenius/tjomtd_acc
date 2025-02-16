# Isometric Maze Tower Defence Game: Map Creation Guide

This document explains how to create maps for the **Isometric Maze Tower Defence Game**. It covers map alignment, grid details, tile placement rules, and debugging tools to ensure smooth gameplay.

---

## Table of Contents

1. [Map Alignment](#map-alignment)
2. [Main Grid Overview](#main-grid-overview)
3. [Tile Placement Rules](#tile-placement-rules)
4. [Export Variables for Configuration](#export-variables-for-configuration)
5. [Steps for Creating a New Map](#steps-for-creating-a-new-map)
6. [Debugging Tools](#debugging-tools)

---

## Map Alignment

- The **top-left corner** of the map grid must always align to **tile position (0, 0)**.
- **Out-of-bounds detection**:
  - If the `x` or `y` coordinate of the cursor's `local_to_map()` result is less than 0, the game considers the tile out of bounds.
  - Misaligned maps will cause incorrect tile selection and game logic issues.
- Always ensure the logical and visual **top-left tile** aligns with `(0, 0)`.

---

## Main Grid Overview

To allow more precise tower and unit placement, the **main grid** subdivides each map tile into a 2x2 grid:

- **Main grid dimensions**:
  - **Width** = `MAP_WIDTH * 2`
  - **Height** = `MAP_HEIGHT * 2`
- **Alignment**:
  - The **main grid's (0, 0)** is the **centre of the top-left corner** of the map tile at `(0, 0)`.

This setup enables towers and units to be placed **halfway** between tiles both vertically and horizontally, enhancing strategic placement.

---

## Tile Placement Rules

1. Towers and path impediments are placed on the **main grid**, not the map grid.
2. Placement logic ensures:
   - Towers fit exactly within one **map tile**.
   - Finer placement granularity is respected using the 2x2 **main grid** subdivision.
3. Placement validation:
   - Impediments and towers must not block all mob paths.
   - Use `can_place_tower()` and `can_add_single_point_impediment()` to verify placement.

---

## Export Variables for Configuration

When setting up a map, configure the following exported variables:

| Variable                  | Description                                    |
|---------------------------|------------------------------------------------|
| `MAP_WIDTH`               | Horizontal number of tiles in the map grid.   |
| `MAP_HEIGHT`              | Vertical number of tiles in the map grid.     |
| `PATH_START` (Vector2i)   | Starting point of the mob path (main grid).   |
| `PATH_END` (Vector2i)     | Ending point of the mob path (main grid).     |
| `PATH_VISIBLE` (bool)     | Toggle to show or hide the mob path visually. |

---

## Steps for Creating a New Map

1. **Define Map Dimensions**:
   - Set `MAP_WIDTH` and `MAP_HEIGHT` in the inspector.
   - Ensure the **top-left corner tile** is at `(0, 0)`.

2. **Configure the Main Grid**:
   - The main grid is initialized in the `_ready()` function using `create_main_tileset()`.
   - Verify that the main grid's `(0, 0)` is aligned with the **centre of the top-left corner** of the `(0, 0)` map tile.

3. **Define Path Start and End**:
   - Assign `PATH_START` and `PATH_END` to define mob movement.

4. **Validate Placement**:
   - Use `can_place_tower()` and `can_add_single_point_impediment()` to ensure all placements allow valid paths.

5. **Debug Path Visibility**:
   - Set `PATH_VISIBLE` to `true` in the inspector to display the mob path.

---

## Debugging Tools

Use the following methods to debug and test the map during development:

1. **Path Impediment Testing**:
   - Add visual markers using:
     ```gdscript
     add_test_single_point_path_impediment_sprite(mainGridTile)
     ```

2. **Tower Placement Testing**:
   - Highlight placement tiles with:
     ```gdscript
     add_test_tower_sprite(placementGridTile)
     ```

3. **Path Visibility**:
   - Set `PATH_VISIBLE = true` to render the current mob path.

---

By following this guide, you can create well-structured maps that are aligned with game mechanics and ready for use in the isometric maze tower defence game.
