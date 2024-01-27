extends Area2D

@export var speed : float = 200

var base_gun_offset_x : int = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	base_gun_offset_x = $Gun.offset.x

func _input(event):
	if event.is_action_pressed("shoot_primary"):
		var bullet = Sprite2D.new()
		bullet.texture = load("res://Assets/Sprites/gun.png")
		var root = get_tree().root.get_child(0)
		bullet.position = self.position
		root.add_child(bullet)
		
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
		self.position.x += speed*delta
		moving = true
	if Input.is_action_pressed("move_left"):
		self.position.x -= speed*delta
		moving = true
	
	var angle_to_mouse = self.position.angle_to_point(get_global_mouse_position())
	$Gun.rotation = fposmod(angle_to_mouse, 2 * PI)
	$Gun.flip_v = $Gun.rotation > PI/2 and $Gun.rotation < 3*PI/2
	$Gun.offset.x = (0.5 * abs(cos($Gun.rotation)) + 0.5)*base_gun_offset_x
	if $Gun.rotation > 5*PI/4 and $Gun.rotation < 7*PI/4:
		if $Skin.get_index()<$Gun.get_index():
			self.move_child($Gun, $Skin.get_index())
	else:
		if $Skin.get_index()>$Gun.get_index():
			self.move_child($Gun, $Skin.get_index()+1)
	
	if moving:
		$Skin.play("walk")
	else:
		$Skin.play("idle")
