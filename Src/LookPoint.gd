extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Divided by 4.0, why? Who knows! :D
	var screenSize : Vector2 = -(DisplayServer.screen_get_size()/4.0)
	self.position = screenSize+(($"../Player".position*3+get_global_mouse_position())/4.0)
	#print(self.position)
