extends Area2D
class_name Bullet

var vector: Vector2
var start_time : int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_time = Time.get_ticks_msec()
	pass

func _physics_process(delta: float) -> void:
	position += vector
	if Time.get_ticks_msec() - start_time > 1000:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
