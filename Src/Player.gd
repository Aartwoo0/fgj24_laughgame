extends Area2D

@export var speed : float = 200
var health : int = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
		
	if moving:
		$Skin.play("walk")
	else:
		$Skin.play("idle")


func _on_enemy_area_entered(area):
	self.health -= 10
