extends CharacterBody2D

var bullet_scene = preload("res://bullet.tscn")
var bullets_node : Node2D

const SPEED = 300.0
const BASE_SPEED = 20.0
const MOVE_SPEED = 40.0

func _ready() -> void:
	bullets_node = get_tree().root.get_node("Game/Bullets");

func _physics_process(delta: float) -> void:

	var x_speed = BASE_SPEED
	var y_speed = 0

	if Input.is_action_just_pressed("ui_accept"):
		if bullets_node:
			var bullet = bullet_scene.instantiate() as Bullet
			bullet.global_position = global_position + Vector2(20,0)
			bullet.vector = Vector2(20,0) * 50
			bullets_node.add_child(bullet)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("ui_left", "ui_right" )
	var direction_y := Input.get_axis("ui_up", "ui_down" )

	if direction_x:
		x_speed += direction_x * MOVE_SPEED

	if direction_y:
		y_speed += direction_y * MOVE_SPEED

	velocity.x = x_speed * SPEED * delta
	velocity.y = y_speed * SPEED * delta

	move_and_slide()
