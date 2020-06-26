extends KinematicBody2D

var walk_speed = 100
var run_speed = 250
var jump_speed = -410
var gravity = 1200
var jumping = false
var velocity = Vector2()
var is_demo_mode = false
var is_demo_mode_running = false

func _get_input():
	_external_input()

func _external_input():
	if is_demo_mode: 
		WalkOrRun()
		return

	if Input.is_key_pressed(KEY_SPACE) && !jumping && is_on_floor():
		Jump()
	if Input.is_key_pressed(KEY_CONTROL):
		SpeedRun()
	else:
		SpeedWalk()

func WalkOrRun():
	if is_demo_mode_running:
		SpeedRun()
	else:
		SpeedWalk()

func SpeedRun():
	if is_demo_mode: is_demo_mode_running = true
	
	velocity.x = run_speed
	$AnimatedSprite.frames.set_animation_speed("walking", 10)

func SpeedWalk():
	if is_demo_mode: is_demo_mode_running = false
	
	velocity.x = walk_speed
	$AnimatedSprite.frames.set_animation_speed("walking", 5)

func Jump():
	jumping = true
	velocity.y = jump_speed
	
func _physics_process(delta):
	_get_input()
	velocity.y += delta * gravity
	if jumping && is_on_floor():
		jumping = false
	
	velocity = move_and_slide(velocity, Vector2.UP)
	#if velocity.x != velocity2.x:
	#	var bla = 1
	if abs(velocity.x) < abs(walk_speed):
		walk_speed *= -1
		run_speed *= -1
		$AnimatedSprite.flip_h = walk_speed < 0

func set_demo_mode():
	is_demo_mode = true
