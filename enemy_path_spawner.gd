extends Node
class_name EnemyPathSpawner

@export var count : int
@export var interval : float
@export var enemy : PackedScene
@export var enabled : bool
@export var speed : float
@export var rotates : bool

var instantiated_count : int = 0
var time_left : float = 0

var path : Path2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	var nodes:Array[Node] = find_children("", "Path2D")
	if !nodes.is_empty():
		path = nodes[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if enabled && instantiated_count < count:

		time_left -= delta

		if time_left <= 0:
			_create_enemy()
			time_left = interval

	for node in path.get_children():
		if node is PathFollow2D:
			node.progress_ratio += delta * speed

func _create_enemy() -> void:

	if path != null:

		var follw_path = PathFollow2D.new()
		follw_path.rotates = rotates
		path.add_child(follw_path)
		var new_enemy = enemy.instantiate()
		follw_path.add_child(new_enemy)

		instantiated_count += 1
