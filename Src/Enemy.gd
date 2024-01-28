extends Area2D
class_name Enemy
@export var speed : float = 100
@export var target : Area2D

static var friends : int = 0
static var center : Vector2 = Vector2(100,100)
var state : int = -1000
var mood : int = -1
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.area_entered.connect(self.target._on_enemy_area_entered)
	self.target.area_entered.connect(self._on_player_area_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.target == null:
		return
	
	if self.state < 1:
		if self.mood > 0:
			$AngrySkin.visible = true
			$HappySkin.visible = false
			Enemy.friends-=1
			self.mood = -1
			self.speed = 100
		if not self.has_overlapping_areas():
			self.position = self.position.move_toward(target.position,speed * delta)
		else:
			var direction = self.position.move_toward(target.position,speed * delta) - self.position
			var avoid = PI * 3 / 4
			var random = self.rng.randi_range(-1,1)
			var tangent = Vector2.from_angle(direction.angle() + avoid * random)
			self.position = self.position + tangent *speed * delta
	else:
		if self.mood < 1:
			$AngrySkin.visible = false
			$HappySkin.visible = true
			Enemy.friends+=1
			self.mood = 1
			self.speed = 50
		if not self.has_overlapping_areas():
			self.position = self.position.move_toward(Enemy.center, speed * delta)
		else:
			var direction = self.position.move_toward(Enemy.center,speed * delta) - self.position
			var avoid = PI * 3 / 4
			var random = self.rng.randi_range(-1,1)
			var tangent = Vector2.from_angle(direction.angle() + avoid * random)
			self.position = self.position + tangent * speed * delta
		if Enemy.friends > 0:
			Enemy.center += (self.position - Enemy.center) / Enemy.friends


func _on_player_area_entered(enemy_area):
	if enemy_area == self:
		self.target = null
		self.queue_free()


func _on_enemy_hitbox_area_entered(bullet):
	if bullet is Bullet:
		bullet.visible = false
		if self.state < 1:
			self.state += 500
