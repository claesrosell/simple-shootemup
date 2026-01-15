extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("moving")

func _physics_process(delta: float) -> void:
	pass
