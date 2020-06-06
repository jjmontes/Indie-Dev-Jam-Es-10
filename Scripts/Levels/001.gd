extends Node2D

signal exit

func _on_Exit_player_entered():
	emit_signal("exit")
