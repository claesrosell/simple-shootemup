extends Node

const DEFAULT_SHIP_BASE_SPEED = 50

var ship_base_speed = DEFAULT_SHIP_BASE_SPEED
var target_ship_base_speed = ship_base_speed
var acceleration : float = 100.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ship_base_speed = move_toward(ship_base_speed, target_ship_base_speed, delta * acceleration)

func getShipBaseSpeed() -> float:
	return ship_base_speed

func setTargetShipBaseSpeed(new_ship_base_speed : float, new_acceleration : float) -> void:
	target_ship_base_speed = new_ship_base_speed
	acceleration = new_acceleration
