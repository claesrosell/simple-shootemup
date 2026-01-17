extends Area2D

var vector: Vector2
var start_time : int
var life_time : float = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_time = Time.get_ticks_msec()
	pass

func _physics_process(delta: float) -> void:
	position += vector * delta
	life_time -= delta
	if life_time < 0:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
