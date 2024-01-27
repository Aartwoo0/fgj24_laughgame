extends Area2D

# Required by the pool.gd
@export var dead : bool = false
@export var speed : float = 100

# When the bullet is far enough from the tree, it is removed
@export var originator : Area2D = null
@export var dissappear_threshold : float = 1000

var origin = Vector2(0,0)

var direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func shoot(towards):
	direction=towards
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if originator!=null:
		origin = originator.position
		
	self.position += direction*speed*delta
	$Jacket.rotation = direction.angle()
	
	if origin.distance_to(self.position)>dissappear_threshold:
		# TODO: Find a smarter way to pool
		pass 
		#.here_is_your_bullet_back(self)
	
