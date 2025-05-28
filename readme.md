# TjomTD

## Overview

TjomTD is a maze tower defense game where you strategically build a maze with towers and barricades to fend off waves of creeps. Each round, you’ll choose from randomly generated towers to shape the path and defend your base.

## How to Get Started

To get the game up and running, follow these simple steps:

1. **Download the Project**: https://github.com/MarcoNachenius/tjomtd_acc/archive/refs/heads/main.zip

2. **Install Godot**: Download the latest version of the Godot Engine from the official website: https://godotengine.org/download

3. **Import the Project**:
   - Open Godot. When prompted, select "Import Existing Project" instead of "Create New Project."
   - Navigate (or "cd") into the directory where you downloaded the project, which contains the `project.godot` file.
   - Select the `project.godot` file to import the project.

4. **Run the Game**:
   - After importing, just press the Play button or press F5. The demo scene is already set as the main scene, so you’ll jump right into the action!

## Game Rules

- **Maze Building**: Each round, you're given 5 random towers to choose from, and you get to decide where to place each one as long as it does not block the creeps' path completely.
- **Tower Selection**: Choose one tower to place; the other four become barricades.
- **Barricades**: Only barricades can be removed, not placed towers. Towers can be upgraded and may become barricades at a later stage.
- **Creep Pathing**:


## Controls and Gameplay

### Navigation Mode
- **Entering Navigation Mode**: You are in navigation mode when the game starts, when a wave ends, or when you press the "Exit Build Mode" button.
- **Panning the Map**: While in navigation mode, hold down the left mouse button and drag to move the map in the desired direction.
- **Zooming**: Use the scroll wheel to zoom in and out of the map.

### Build Mode
- **Entering Build Mode**: Press the "Build Random Tower" button to enter build mode.
- **Placing Towers**:
  - While in build mode, hold down the left mouse button to preview the tower placement area on the map.
  - The preview will show the surface of the tower with a color highlight:
    - If the surface highlight is **green**, the position is valid and will not block the creeps' path. Releasing the left mouse button will place the tower.
    - If the surface highlight is **red**, the position is invalid, meaning it would block the path, extend beyond map boundaries, or occupy mandatory waypoints. Releasing the left mouse button will not place the tower in this case.
