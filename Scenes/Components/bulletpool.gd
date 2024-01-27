extends Node
const Pool = preload("res://addons/pool.gd")

const BULLET_POOL_SIZE = 60
const BULLET_POOL_PREFIX = "bullet"




@onready var pool = Pool.new(BULLET_POOL_SIZE, BULLET_POOL_PREFIX, $Bullet)

func give_me_bullet_please():
	return pool.get_first_dead()
func here_is_your_bullet_back(bullet):
	bullet.hide()
