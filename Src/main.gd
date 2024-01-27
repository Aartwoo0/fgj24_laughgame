extends Node2D

var aimCursor = load("res://Assets/aim.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(aimCursor)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
