extends Control

func player_lives(count):
	$MarginContainer/VBoxContainer/LifesContainer/Count.text = str(count)
