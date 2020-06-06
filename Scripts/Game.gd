extends Node2D

var current_level
var player = preload("res://Scenes/Player.tscn")
var levels = [
	preload("res://Scenes/Levels/001.tscn")
]

func _ready():
	load_level(0)

func _on_level_exit():
	print("El jugador salio del nivel... cargando nivel 2")
	current_level.queue_free()

func load_level(level_index):
	current_level = levels[level_index].instance()
	current_level.connect("exit", self, "_on_level_exit")
	current_level.add_player(player.instance())
	add_child(current_level)
