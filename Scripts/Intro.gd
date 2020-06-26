extends "res://Scripts/Levels/Level.gd" #Node2D

#var player_in_level
var timer = Timer.new()
const unpressed_color = Color("#2f2f38")
const pressed_color = Color("#53745a")

func _ready():
	$ButtonJump.color = unpressed_color
	$ButtonSpeed.color = unpressed_color
	
	timer.set_one_shot(true)
	timer.set_wait_time(0.6)
	timer.connect("timeout", self, "_jump_button_unpressed")
	add_child(timer)

func add_player(player):
	.add_player(player)
	if player_in_level != null:
		player_in_level.set_demo_mode()
		$AnimationPlayer.play("demo")

#func remove_player():
#	if player_in_level != null:
#		call_deferred("remove_child", player_in_level)
#
#func _on_AreaDead_player_entered(body):
#	if body.is_in_group("player"):
#		emit_signal("dead")


func demo_player_jump():
	$Player.Jump()
	$ButtonJump.color = pressed_color
	timer.start()

func demo_player_run():
	$Player.SpeedRun()
	$ButtonSpeed.color = pressed_color

func demo_player_walk():
	$Player.SpeedWalk()
	$ButtonSpeed.color = unpressed_color

func _jump_button_unpressed():
	$ButtonJump.color = unpressed_color
