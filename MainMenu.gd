extends Control

var withSave  = false

const menu_options = preload("res://MenuOptions.tscn")
var menu_options_inst = null

func _on_Button_pressed():
	get_tree().change_scene_to_file("res://Game.tscn")

func _input(event):
	if (event is InputEventKey and not event.is_echo()):
		if event.pressed and event.keycode == KEY_ESCAPE:
			if menu_options_inst == null:
				menu_options_inst = menu_options.instantiate()
				add_child(menu_options_inst)
			else:
				remove_child(menu_options_inst)
				menu_options_inst = null
			
func _on_menu_options_button_pressed():
	menu_options_inst = menu_options.instantiate()
	add_child(menu_options_inst)        
