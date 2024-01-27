extends Node2D

var enemyTemplate : PackedScene = load("res://Scenes/Components/enemy.tscn")
var aimCursor = load("res://Assets/aim.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(aimCursor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_spawn():
	var enemy = enemyTemplate.instantiate()
	self.add_child(enemy)
	enemy.position.x = 100
	enemy.position.y = 100
	enemy.target = $Player

