extends Node2D

var enemyTemplate : PackedScene = load("res://Scenes/Components/enemy.tscn")
var aimCursor = load("res://Assets/aim.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(aimCursor)
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_spawn():
	var enemy = enemyTemplate.instantiate()
	enemy.position.x = 100
	enemy.position.y = 100
	enemy.target = $Player
	self.add_child(enemy)