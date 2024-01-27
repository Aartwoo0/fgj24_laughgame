extends Area2D

@export var speed : float = 100
var direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func shoot(towards):
	direction=towards
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += direction*speed*delta
	print(self.position)
	$Jacket.rotation = direction.angle()
	
