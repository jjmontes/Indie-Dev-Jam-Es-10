extends Node2D

var current_level
var index_level = 0
var lives
var player = preload("res://Scenes/Player.tscn")
var uiScene = preload("res://Scenes/UI.tscn")
var ui
var levels = [
	preload("res://Scenes/Intro.tscn"),
	preload("res://Scenes/Levels/001.tscn"),
	preload("res://Scenes/Levels/002.tscn"),
	preload("res://Scenes/Levels/003.tscn"),
	preload("res://Scenes/Levels/004.tscn"),
]
var gameOverScene = preload("res://Scenes/GameOver.tscn")
var winScene = preload("res://Scenes/Win.tscn")
var menuScene = preload("res://Scenes/Menu.tscn")
var menu

func _ready():
	load_menu()

func _on_level_exit():
	current_level.win_level()
	yield(get_tree().create_timer(2.0), "timeout")
	current_level.queue_free()
	load_level(index_level + 1)

func _on_level_dead():
	#TODO: Escena de perder
	current_level.remove_player()
	lives -= 1
	if lives >= 0:
		ui.player_lives(lives)
		current_level.add_player(player.instance())
	else:
		_game_over()

func _game_over():
	ui.queue_free()
	current_level.queue_free()
	var gameOver = gameOverScene.instance()
	$CanvasLayer.add_child(gameOver)
	yield(get_tree().create_timer(3.0), "timeout")
	gameOver.queue_free()
	load_menu()

func load_level(index):
	if levels.size() <= index:
		_win()
	else:
		current_level = levels[index].instance()
		current_level.connect("exit", self, "_on_level_exit")
		current_level.connect("dead", self, "_on_level_dead")
		current_level.add_player(player.instance())
		call_deferred("add_child", current_level)
		index_level = index

func _win():
	current_level.queue_free()
	var win = winScene.instance()
	$CanvasLayer.add_child(win)
	yield(get_tree().create_timer(3.0), "timeout")
	win.queue_free()
	load_menu()

func load_menu():
	menu = menuScene.instance()
	menu.connect("option_play_selected", self, "_on_menu_option_play_selected")
	menu.connect("option_credits_selected", self, "_on_menu_option_credits_selected")
	$CanvasLayer.add_child(menu)

func _on_menu_option_play_selected():
	lives = 3
	ui = uiScene.instance()
	ui.player_lives(lives)
	$CanvasLayer.add_child(ui)
	load_level(index_level)
	menu.queue_free()

func _on_menu_option_credits_selected():
	menu.ShowCredits()
