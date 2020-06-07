extends Node2D

var current_level
var index_level = 0
var player = preload("res://Scenes/Player.tscn")
var levels = [
	preload("res://Scenes/Levels/001.tscn"),
	preload("res://Scenes/Levels/002.tscn"),
]
var menuScene = preload("res://Scenes/Menu.tscn")
var menu

func _ready():
	load_menu()

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
	call_deferred("add_child", current_level)
	index_level = index

func load_menu():
	menu = menuScene.instance()
	menu.connect("option_play_selected", self, "_on_menu_option_play_selected")
	menu.connect("option_credits_selected", self, "_on_menu_option_credits_selected")
	$CanvasLayer.add_child(menu)

func _on_menu_option_play_selected():
	load_level(index_level)
	menu.queue_free()

func _on_menu_option_credits_selected():
	print("Creditos")
