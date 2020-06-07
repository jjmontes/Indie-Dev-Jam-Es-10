extends Control

onready var menuOptions = get_tree().get_nodes_in_group("menuOption")

func _get_input():
	if Input.is_action_just_pressed("ui_up"):
		_menu_up()
	elif Input.is_action_just_pressed("ui_down"):
		_menu_down()

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
	
func _process(delta):
	_get_input()
