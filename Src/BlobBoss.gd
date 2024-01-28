extends Area2D

@onready var health_display = %BossHealth
var health = 1000

func _ready():
	health_display.text = 'Boss: ' + str(self.health)
	
	$BulletShield.area_entered.connect(self._on_boss_area_hit)
		
func _on_boss_area_entered(somebody):
	if somebody is Enemy and somebody.state > 0:
		somebody.state = -1000
		
		self.health -= 100
		health_display.text = 'Boss: ' + str(self.health)

func _on_boss_area_hit(object):
	if object is Bullet:
		object.deflect()
	

