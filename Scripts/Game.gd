extends Node2D

var current_level
var index_level = 0
var player = preload("res://Scenes/Player.tscn")
var levels = [
	preload("res://Scenes/Levels/001.tscn")
]

func _ready():
	load_level(index_level)

func _on_level_exit():
	current_level.queue_free()
	load_level(index_level + 1)

func load_level(index):
	if levels.size() <= index:
		print("Se acabaron los niveles... digamos que ganaste...")
		return
	current_level = levels[index].instance()
	current_level.connect("exit", self, "_on_level_exit")
	current_level.add_player(player.instance())
	add_child(current_level)
	index_level = index
