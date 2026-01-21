extends Area2D
class_name Bullet

var vector: Vector2
var time_left : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_left = 0.75
	pass

func _physics_process(delta: float) -> void:
	position += vector * delta
	time_left -= delta
	if time_left < 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()
