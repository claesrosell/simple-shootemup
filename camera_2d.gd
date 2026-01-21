extends Camera2D

@export var target: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	var speed = GameManager.getShipBaseSpeed()

	var pX = position.x
	var pY = position.y

	if target != null:
		pX = target.global_position.x
		pY = target.global_position.y

		position.x = move_toward(position.x, pX, speed )
		position.y = move_toward(position.y, pY, speed )
	else:
		position.x = pX + speed * delta
#		position.y = pY + speed * delta
