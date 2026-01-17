extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var enabled := false

func _ready() -> void:
	animation_player.play("moving")

func _physics_process(delta: float) -> void:
	if enabled && !(get_parent() is PathFollow2D):
		position += Vector2(-100,0) * delta

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	print("enabled")
	enabled = true

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	enabled = false
