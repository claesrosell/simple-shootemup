extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var bullet_scene = preload("res://enemy_bullet.tscn")
var bullets_node : Node2D

var enabled := true

var fire_rate : float = 2
var fire_time : float = 0

func _ready() -> void:
	animation_player.play("moving")
	bullets_node = get_tree().root.get_node("Game/Bullets");

func _physics_process(delta: float) -> void:
	if enabled && !(get_parent() is PathFollow2D):
		position += Vector2(-100,0) * delta

func _process(delta: float) -> void:
	fire_time -= delta
	if fire_time <= 0:
		fire_time = fire_rate

		if bullets_node:
			var bullet = bullet_scene.instantiate()
			bullet.global_position = global_position + Vector2(-10,0)
			bullet.vector = Vector2(-20,0) * 30
			bullets_node.add_child(bullet)


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("death?")

func _on_area_2d_area_entered(area: Area2D) -> void:
	queue_free()
