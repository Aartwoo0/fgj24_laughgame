extends Node
const Pool = preload("res://addons/pool.gd")

const BULLET_POOL_SIZE = 60
const BULLET_POOL_PREFIX = "bullet"
@onready var pool = Pool.new(BULLET_POOL_SIZE, BULLET_POOL_PREFIX, $Bullet)

func _ready():
	# Attach pool of objects to the bullets node
	pool.add_to_node($Bullets)

func give_me_bullet_please():
	var pooled_bullet = pool.get_first_dead()
	if (pooled_bullet==null):
		assert(pooled_bullet==null, "POOL IS OUT OF BULLETS")
		return
	pooled_bullet.visible = true
	return pooled_bullet
	
func here_is_your_bullet_back(bullet):
	bullet.visible = false
	pool._on_killed(bullet)
