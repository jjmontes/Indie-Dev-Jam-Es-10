extends KinematicBody2D

var walk_speed = 100
var run_speed = 250
var jump_speed = -410
var gravity = 1200
var jumping = false
var velocity = Vector2()

func _get_input():
	velocity.x = walk_speed
	$AnimatedSprite.frames.set_animation_speed("walking", 5)
	if Input.is_key_pressed(KEY_SPACE) && !jumping && is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if Input.is_key_pressed(KEY_CONTROL):
		velocity.x = run_speed
		$AnimatedSprite.frames.set_animation_speed("walking", 10)

func _ready():
	pass
	
func _physics_process(delta):
	_get_input()
	velocity.y += delta * gravity
	if jumping && is_on_floor():
		jumping = false
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if abs(velocity.x) < abs(walk_speed):
		walk_speed *= -1
		run_speed *= -1
		$AnimatedSprite.flip_h = walk_speed < 0
