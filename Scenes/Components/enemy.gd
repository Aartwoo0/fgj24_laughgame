extends Area2D

@export var speed : float = 100
@export var target : Area2D
var state: int = -1000
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if state < 0:
		$AngrySkin.visible = true
		$HappySkin.visible = false
	else:
		$AngrySkin.visible = false
		$HappySkin.visible = true
	
	if not self.has_overlapping_areas():
		self.position = self.position.move_toward(target.position,speed * delta)
	else:
		var direction = self.position.move_toward(target.position,speed * delta) - self.position
		var tangent = direction.from_angle(PI * 3 / 4 * self.rng.randi_range(-1,1))
		self.position = self.position + tangent

func _on_player_area_entered(area):
	self.queue_free()
