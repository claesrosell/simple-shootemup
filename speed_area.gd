extends Area2D
class_name SpeedArea

@export var enter_speed : float
@export var exit_speed : float
@export var acceleration : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	self.area_exited.connect(_on_area_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_entered(area : Area2D) -> void:
	print("testar")
	GameManager.setTargetShipBaseSpeed(enter_speed, acceleration)

func _on_area_exited(area : Area2D) -> void:
	GameManager.setTargetShipBaseSpeed(exit_speed, acceleration)
	print("testar2")
