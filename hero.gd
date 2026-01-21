extends CharacterBody2D
class_name Hero

signal health_updated(new_health:int)
signal shield_updated(new_shield:int)

var bullet_scene = preload("res://bullet.tscn")
var bullets_node : Node2D

const SPEED = 300.0
const BASE_SPEED = 20.0
const MOVE_SPEED = 40.0

const BULLET_SPEED = 2000.0

var shield:int = 100
var health:int = 100

enum BulletType { SINGLE, TRIPLE, TRIPLE2 }

var bullet_type : BulletType = BulletType.TRIPLE

func _ready() -> void:
	bullets_node = get_tree().root.get_node("Game/Bullets");

	# Make sure that the labels in the HUD is updated by modifing the health
	self._modify_health(self.health)
	self._modify_shield(self.shield)

func _physics_process(delta: float) -> void:

	var x_speed = BASE_SPEED
	var y_speed = 0

	fire()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x := Input.get_axis("player1_left", "player1_right" )
	var direction_y := Input.get_axis("player1_up", "player1_down" )

	if direction_x:
		x_speed += direction_x * MOVE_SPEED

	if direction_y:
		y_speed += direction_y * MOVE_SPEED

	velocity.x = x_speed * SPEED * delta
	velocity.y = y_speed * SPEED * delta

	move_and_slide()

func fire() -> void:
	if Input.is_action_just_pressed("player1_fire"):
		if bullets_node:
			var bullet = bullet_scene.instantiate() as Bullet
			bullet.global_position = global_position + Vector2(20,0)
			bullet.vector = Vector2(1,0) * BULLET_SPEED
			bullets_node.add_child(bullet)

			if bullet_type == BulletType.TRIPLE:
				var bullet2 = bullet_scene.instantiate() as Bullet
				bullet2.global_position = global_position + Vector2(20,-15)
				bullet2.vector = Vector2(1,0) * BULLET_SPEED
				bullets_node.add_child(bullet2)

				var bullet3 = bullet_scene.instantiate() as Bullet
				bullet3.global_position = global_position + Vector2(20,15)
				bullet3.vector = Vector2(1,0) * BULLET_SPEED
				bullets_node.add_child(bullet3)

			if bullet_type == BulletType.TRIPLE2:
				var bullet2 = bullet_scene.instantiate() as Bullet
				bullet2.global_position = global_position + Vector2(20,-10)
				bullet2.vector = Vector2(2,-1).normalized() * BULLET_SPEED
				bullets_node.add_child(bullet2)

				var bullet3 = bullet_scene.instantiate() as Bullet
				bullet3.global_position = global_position + Vector2(20,10)
				bullet3.vector = Vector2(2,1).normalized() * BULLET_SPEED
				bullets_node.add_child(bullet3)

func apply_damage(damage_points:int) -> void:
	var shield_value = self.shield
	var health_value = self.health
	var new_shield_value = shield_value - damage_points
	var new_health_value = health_value
	if new_shield_value < 0:
		new_health_value = new_health_value + new_shield_value # New shield value is negative so this will decrease health
		new_shield_value = 0
	_modify_health(new_health_value)
	_modify_shield(new_shield_value)
	if new_health_value <= 0:
		print("Death")

func _modify_health(health_value:int):
	self.health = max(0, health_value)
	self.health_updated.emit(self.health)

func _modify_shield(shield_value:int):
	self.shield = max(0, shield_value)
	self.shield_updated.emit(self.shield)


func _on_shield_timer_timeout() -> void:
	if self.health > 0:
		_modify_shield( clamp(self.shield + 1, 0, 100) )	# Increase shield with 1
