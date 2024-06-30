extends Node2D

var vol_music = 100	
var vol_click = 100 
var window_mode = DisplayServer.WINDOW_MODE_WINDOWED

var withSave  = false

func _ready():
	await _getSave()

func _getSave():	
	var file = FileAccess.open("res://settings.txt", FileAccess.READ)
	
	var var_vol_music = file.get_var()
	if var_vol_music != null:
		vol_music = var_vol_music
		$MenuOptions/VolumeMusicBar.value = vol_music
		
	var var_vol_click = file.get_var()
	if var_vol_click != null:
		vol_click = var_vol_click
		$MenuOptions/VolumeClickBar.value = vol_click
		
	var var_window_mode = file.get_var()
	if var_window_mode != null:
		$MenuOptions/WindowModeList.selected = window_mode
		setwindow_mode(window_mode)
		
	file.close()

func _on_volume_music_changed(value_changed):
	vol_music = $MenuOptions/VolumeMusicBar.value

func _on_volume_click_changed(value_changed):
	vol_click = $MenuOptions/VolumeClickBar.value
	
func _on_button_save_down():
	var main_scene = get_node("/root/Control")
	main_scene.remove_child(main_scene.menu_options_inst)
	await _saveSave()			
	
func _on_window_mode_selected(value):
	setwindow_mode(value)
	
func setwindow_mode(value:DisplayServer.WindowMode):
	window_mode = value 
	DisplayServer.window_set_mode(value)

func _saveSave():
	var file = FileAccess.open("res://settings.txt", FileAccess.READ_WRITE)
	file.store_var(vol_music)
	file.store_var(vol_click)
	#file.store_var(window_mode as DisplayServer.WindowMode) 
	
	file.close()
