extends Node2D

var enemyTemplate : PackedScene = load("res://Scenes/Components/enemy.tscn")
var aimCursor = load("res://Assets/aim.png")
var rng = RandomNumberGenerator.new()

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
	enemy.position.x = $Boss.position.x + rng.randi_range(-50,50)
	enemy.position.y = $Boss.position.y + 50
	enemy.target = $Player
	self.add_child(enemy)
	
	enemy.area_entered.connect($Player._on_enemy_area_entered)
	$Player.area_entered.connect(enemy._on_player_area_entered)
	
