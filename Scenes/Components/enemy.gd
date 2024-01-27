extends Area2D

@export var speed : float = 100
@export var target : Area2D
var state: int = -1000
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.area_entered.connect(self.target._on_enemy_area_entered)
	self.target.area_entered.connect(self._on_player_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.target == null:
		return
	
	if state < 0:
		$AngrySkin.visible = true
		$HappySkin.visible = false

		if not self.has_overlapping_areas():
			self.position = self.position.move_toward(target.position,speed * delta)
		else:
			var direction = self.position.move_toward(target.position,speed * delta) - self.position
			var avoid = PI*3/4
			var random = self.rng.randi_range(-1,1)
			var tangent = Vector2.from_angle(direction.angle() + avoid * random)
			self.position = self.position + tangent *speed * delta
	else:
		$AngrySkin.visible = false
		$HappySkin.visible = true

func _on_player_area_entered(enemy_area):
	if enemy_area == self:
		self.state = 1;
	#	self.target = null
	#	self.queue_free()
