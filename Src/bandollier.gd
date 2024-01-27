extends Node

# Pool 60 bullets
const pool = preload("res://addons/pool.gd")
const heartBullet = preload("res://Scenes/Components/bullet.tscn")
const BULLET_POOL_SIZE = 60
const BULLET_POOL_PREFIX = "bullet"
@onready var heartBulletPool = pool.new(BULLET_POOL_SIZE, BULLET_POOL_PREFIX, heartBullet)

# Called when the node enters the scene tree for the first time.
func _ready():
	heartBulletPool.add_to_node(self)
	
func get_next_bullet():
	return heartBulletPool.pop_first_dead()
