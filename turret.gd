extends Area2D

signal turret_shot(laser)

@onready var pipe_sprite = $PipeSprite
@onready var laser_creation_point := $LaserCreationPoint
@onready var bullets_node = get_tree().root.get_node("Game/Bullets");

# The center angle the turret starts at (and sweeps around)
@export var canon_degree: float = 0

# How far (in degrees) the turret rotates to the left/right of the center
@export var min_angle: float = -75.0
@export var max_angle: float = 75.0

# How fast the turret moves (degrees per second)
@export var sweep_speed: float = 50

var current_angle: float
var sweep_direction: int = 1 # 1 = Clockwise, -1 = Counter-Clockwise

var turret_laser_scene = preload("res://turret_laser.tscn")

func _ready():
	# Initialize the starting angle
	current_angle = canon_degree

	# Apply start angle to sprite
	pipe_sprite.rotation_degrees = current_angle

func _physics_process(delta:float):
	current_angle += sweep_speed * sweep_direction * delta

	# Check the extremes and flip if neccessery
	if current_angle >= max_angle:
		current_angle = max_angle
		sweep_direction = -1

	elif current_angle <= min_angle:
		current_angle = min_angle
		sweep_direction = 1

	pipe_sprite.rotation_degrees = current_angle

func shoot_laser() -> void:
	var laser_shot := turret_laser_scene.instantiate()
	laser_shot.global_position = pipe_sprite.global_position
	laser_shot.rotation = pipe_sprite.rotation
	bullets_node.add_child(laser_shot)
	emit_signal("turret_shot", laser_shot)
	pass

func _on_timer_timeout() -> void:
		shoot_laser()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
