extends Control

signal option_play_selected
signal option_credits_selected

var signals = {
	0: "option_play_selected",
	1: "option_credits_selected"
}

onready var menuOptions = get_tree().get_nodes_in_group("menuOption")

func _get_input():
	if Input.is_action_just_pressed("ui_up"):
		_menu_up()
	elif Input.is_action_just_pressed("ui_down"):
		_menu_down()
	elif Input.is_action_just_pressed("ui_select"):
		_emit_signal_option()

func _menu_up():
	for menu in menuOptions:
		if !menu.get_editor_only():
			menu.set_editor_only(true)
			var index = menuOptions.find(menu)
			if index <= 0:
				index = menuOptions.size()
			menuOptions[index - 1].set_editor_only(false)
			return
	
func _menu_down():
	for menu in menuOptions:
		if !menu.get_editor_only():
			menu.set_editor_only(true)
			var index = menuOptions.find(menu)
			if index >= menuOptions.size() - 1:
				index = -1
			menuOptions[index + 1].set_editor_only(false)
			return

func _emit_signal_option():
	for menu in menuOptions:
		if !menu.get_editor_only():
			var index = menuOptions.find(menu)
			emit_signal(signals[index])

func _process(_delta):
	_get_input()

func _on_Close_pressed():
	$PopupDialog.hide()

func ShowCredits():
	var file = File.new()
	file.open("res://credits.txt", File.READ)
	var content = file.get_as_text()
	file.close()
	$PopupDialog/Text.text = content
	$PopupDialog.popup()
