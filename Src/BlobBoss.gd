extends Area2D

@onready var health_display = %BossHealth
var health = 1000

func _ready():
	health_display.text = 'Boss: ' + str(self.health)
	self.area_entered.connect(self._on_boss_area_entered)
	$BulletShield.area_entered.connect(self._on_boss_area_hit)
		
func _on_boss_area_entered(somebody):
	if somebody is Enemy and somebody.state > 0:
		somebody.state = -1000
		
		self.health -= 100
		health_display.text = 'Boss: ' + str(self.health)
		
		if self.health == 0:
			Globals.won_last_game = true
			get_tree().change_scene_to_file("res://Scenes/Levels/TheEnd.tscn")

func _on_boss_area_hit(object):
	if object is Bullet:
		object.deflect()
	

