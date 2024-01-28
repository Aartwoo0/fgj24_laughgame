extends Area2D
class_name Player
@onready var player_health = %PlayerHealth

@export var speed : float = 200
@export var bandolier : Node = null
@export var health : int = 1000

var base_gun_offset_x : int = 10
var weapon_of_choice : Sprite2D = null

# I could not figure out under time pressure how to do this with animations
var hitting_with_a_stick_ugly_quickfix = 0.0
const SWING_SPEED = 0.2
const SWING_STRENGTH = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	base_gun_offset_x = $Gun.offset.x
	weapon_of_choice = $Gun
	
func _input(event):
	if event.is_action_pressed("shoot_primary"):
		if $Gun.visible:
			var bullet = bandolier.get_next_bullet()
			bullet.originator = self
			bullet.position = $Gun.global_position + Vector2.from_angle($Gun.rotation)*base_gun_offset_x
			bullet.visible = true
			bullet.shoot(Vector2.from_angle($Gun.rotation))
		elif hitting_with_a_stick_ugly_quickfix<=0.0:
			hitting_with_a_stick_ugly_quickfix = SWING_SPEED
			
	if event.is_action_released("next_weapon"):
		if $Gun.visible:
			weapon_of_choice = $Stick
			$Gun.visible = false
			$Stick.visible = true
		else:
			weapon_of_choice = $Gun
			$Gun.visible = true
			$Stick.visible = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var moving = false
	if Input.is_action_pressed("move_down"):
		self.position.y += speed*delta
		moving = true
	if Input.is_action_pressed("move_up"):
		self.position.y -= speed*delta
		moving = true
	if Input.is_action_pressed("move_right"):
		self.position.x += speed * delta
		moving = true
	if Input.is_action_pressed("move_left"):
		self.position.x -= speed * delta
		moving = true
	
	if hitting_with_a_stick_ugly_quickfix>0.0:
		if hitting_with_a_stick_ugly_quickfix>3.0*SWING_SPEED/4.0:
			$Stick.rotation+=SWING_STRENGTH*PI*delta
		elif hitting_with_a_stick_ugly_quickfix>SWING_SPEED/4.0:
			$Stick.rotation-=SWING_STRENGTH*PI*delta
		else:
			$Stick.rotation+=SWING_STRENGTH*PI*delta
		hitting_with_a_stick_ugly_quickfix-=delta;
	else:
		var angle_to_mouse = self.position.angle_to_point(get_global_mouse_position())
		weapon_of_choice.rotation = fposmod(angle_to_mouse, 2 * PI)
		weapon_of_choice.flip_v = weapon_of_choice.rotation > PI/2 and weapon_of_choice.rotation < 3*PI/2
		weapon_of_choice.offset.x = (0.5 * abs(cos(weapon_of_choice.rotation)) + 0.5)*base_gun_offset_x
	
	if weapon_of_choice.rotation > 5*PI/4 and weapon_of_choice.rotation < 7*PI/4:
		if $PlayerSkin.get_index()<weapon_of_choice.get_index():
			self.move_child(weapon_of_choice, $PlayerSkin.get_index())
	else:
		if $PlayerSkin.get_index()>weapon_of_choice.get_index():
			self.move_child(weapon_of_choice, $PlayerSkin.get_index()+1)
	
	# This is just manually coded hit animation
	
	
	
	if moving:
		$PlayerSkin.play("walk")
	else:
		$PlayerSkin.play("idle")

func _on_enemy_area_entered(enemy_area):
	if enemy_area is Player:
		self.health -= 100
		player_health.text = 'Player: ' + str(self.health)
