extends Node2D

var preload_config = preload("res://configs.gd")
var config = preload_config.new()

func _ready():
	await _getSave()

func _getSave():	
	var file = FileAccess.open("res://settings.txt", FileAccess.READ)
	
	var var_vol_music = file.get_var()
	if var_vol_music != null:
		config.vol_music = var_vol_music
		$Background/VolumeMusicBar.value = config.vol_music
		
	var var_vol_click = file.get_var()
	if var_vol_click != null:
		config.vol_click = var_vol_click
		$Background/VolumeClickBar.value = config.vol_click
		
	var var_window_mode = file.get_var()
	if var_window_mode != null:
		config.window_mode = var_window_mode
		$Background/WindowModeList.selected = config.window_mode
		setwindow_mode(config.window_mode)
		
	file.close()

func _on_volume_music_changed(value_changed):
	config.vol_music = $Background/VolumeMusicBar.value

func _on_volume_click_changed(value_changed):
	config.vol_click = $Background/VolumeClickBar.value
	
func _on_button_save_down():
	var main_scene = get_node("/root/MainMenu")
	main_scene.remove_child(main_scene.menu_options_inst)
	await _saveSave()			
	
func _on_window_mode_selected(value):
	setwindow_mode(value)
	
func setwindow_mode(value:DisplayServer.WindowMode):
	config.window_mode = value 
	DisplayServer.window_set_mode(value)

func _saveSave():
	var file = FileAccess.open("res://settings.txt", FileAccess.READ_WRITE)
	file.store_var(config.vol_music)
	file.store_var(config.vol_click)
	file.store_var(config.window_mode as DisplayServer.WindowMode) 
	
	file.close()
