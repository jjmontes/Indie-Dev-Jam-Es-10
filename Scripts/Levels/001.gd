extends Node2D

signal exit

func _on_Exit_player_entered():
	emit_signal("exit")

func add_player(player):
	if player != null && player.is_in_group("player"):
		player.position = $PlayerStartPosition.position
		add_child(player)
