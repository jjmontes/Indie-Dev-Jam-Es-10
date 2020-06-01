extends KinematicBody2D

var walk_speed = 200
var jump_speed = -400
var gravity = 1200
var jumping = false
var velocity = Vector2()

func _get_input():
	velocity.x = walk_speed
	if Input.is_key_pressed(KEY_SPACE) && !jumping && is_on_floor():
		jumping = true
		velocity.y = jump_speed
	elif Input.is_key_pressed(KEY_CONTROL):
		print ("punch")

func _ready():
	pass
	
func _physics_process(delta):
	_get_input()
	velocity.y += delta * gravity
	if jumping && is_on_floor():
		jumping = false
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if velocity.x == 0:
		walk_speed *= -1
		$Sprite.flip_h = walk_speed < 0
	
