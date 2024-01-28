extends Area2D

class_name Stick

var velocity : float = 0.0

var _prev_parent_rotation : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = _prev_parent_rotation-get_parent().rotation
	_prev_parent_rotation = get_parent().rotation
