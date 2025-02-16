extends Node

## More segments for smoother oval, fewer for performance
const COLLISION_SHAPE_PRECISION: int = 16

const STARTING_LIVES: int = 20
const STARTING_BALANCE: int = 10000

# Camera Zoom Constants
const MAX_ZOOM = 2.0
const MIN_ZOOM = 0.1
const ZOOM_SPEED = 0.05