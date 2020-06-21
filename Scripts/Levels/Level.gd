extends Node2D

signal exit
signal dead

var player_in_level

func _on_Exit_player_entered():
	emit_signal("exit")

func add_player(player):
	if player != null && player.is_in_group("player"):
		player_in_level = player
		player_in_level.position = $PlayerStartPosition.position
		call_deferred("add_child", player_in_level)

func remove_player():
	if player_in_level != null:
		call_deferred("remove_child", player_in_level)

func _on_AreaDead_player_entered(body):
	if body.is_in_group("player"):
		emit_signal("dead")
