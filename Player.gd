extends Area2D

@export var speed : float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_down"):
		self.position.y += speed*delta
		print(self.position)
	if Input.is_action_pressed("move_up"):
		self.position.y -= speed*delta
		print(self.position)
	if Input.is_action_pressed("move_right"):
		self.position.x += speed*delta
		print(self.position)
	if Input.is_action_pressed("move_left"):
		self.position.x -= speed*delta
		print(self.position)
