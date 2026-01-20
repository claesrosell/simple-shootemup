extends CanvasLayer

@onready var score_label := $Score
@onready var health_label := $Health
@onready var shield_label := $Shield

@onready var game_node := get_tree().root.get_node("Game");
@onready var hero_node := get_tree().root.get_node("Game/Hero")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_node.score_updated.connect(_update_score)
	hero_node.health_updated.connect(_update_health)
	hero_node.shield_updated.connect(_update_shield)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _update_score(new_score:int) -> void:
	score_label.text = "Score: %s" % [new_score]

func _update_health(new_health:int) -> void:
	health_label.text = "Health: %s" % [new_health]

func _update_shield(new_shield:int) -> void:
	shield_label.text = "Shield: %s" % [new_shield]
