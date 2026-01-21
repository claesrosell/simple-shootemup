extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var bullet_scene = preload("res://sphere_bullet.tscn")
var bullets_node : Node2D
var game_node : Node2D
var enabled := true

var fire_rate : float = 2
var fire_time : float = 0

func _ready() -> void:
	animation_player.play("moving")
	game_node = get_tree().root.get_node("Game")
	bullets_node = get_tree().root.get_node("Game/Bullets")

func _physics_process(delta: float) -> void:
	if enabled && !(get_parent() is PathFollow2D):
		position += Vector2(-100,0) * delta

func _process(delta: float) -> void:
	pass

func fire() -> void:
	if bullets_node:
		var bullet1 = bullet_scene.instantiate()
		bullet1.global_position = global_position + Vector2(-10,0)
		bullet1.vector = Vector2(-20,0) * 30
		bullets_node.add_child(bullet1)

		var bullet2 = bullet_scene.instantiate()
		bullet2.global_position = global_position + Vector2(10,0)
		bullet2.vector = Vector2(20,0) * 30
		bullets_node.add_child(bullet2)

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	self.game_node.modify_score(10)
	animation_player.play("death")
