extends Area2D

@onready var pipe_sprite = $PipeSprite

# The center angle the turret starts at (and sweeps around)
@export var canon_degree: float = 0

# How far (in degrees) the turret rotates to the left/right of the center
@export var min_angle: float = -75.0
@export var max_angle: float = 75.0

# How fast the turret moves (degrees per second)
@export var sweep_speed: float = 50

var current_angle: float
var sweep_direction: int = 1 # 1 = Clockwise, -1 = Counter-Clockwise

func _ready():
	# Initialize the starting angle
	current_angle = canon_degree

	# Apply start angle to sprite
	pipe_sprite.rotation_degrees = current_angle

func _physics_process(delta):
	current_angle += sweep_speed * sweep_direction * delta

	# Check the extremes and flip if neccessery	
	if current_angle >= max_angle:
		current_angle = max_angle
		sweep_direction = -1 

	elif current_angle <= min_angle:
		current_angle = min_angle
		sweep_direction = 1

	pipe_sprite.rotation_degrees = current_angle
