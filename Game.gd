extends Control

const preload_config = preload("res://configs.gd")
var config = null
const particles_scene = preload("res://EffectOnHit.tscn")

const withSave := true

var gold = 0
var diamond = 0
var add = 1
var addpersec = 1

var level = 1
var currentLife = 10
var maxLife = 10

func _ready():	
	await _getSettings()
	await _getSave()
	
	updateLevel(0)
	$BossLife.value = currentLife
	$BossLife.max_value = maxLife
	$BossLife.step = 1
	
func _getSettings():
	var file = FileAccess.open("res://settings.txt", FileAccess.READ)
	
	$Background/BackgroundMusic.volume_db = file.get_var()
	$Monster/HitSound.volume_db = file.get_var()
	# TODO gerer ça avant
	DisplayServer.window_set_mode(file.get_var())

func _getSave():
	if withSave == false:
		return
		
	var file = FileAccess.open("res://save.txt", FileAccess.READ)
	
	var gold_var = file.get_var()
	if gold_var != null:
		gold = gold_var
		
	var add_var = file.get_var()
	if add_var != null:
		add = add_var		
		
	var diamond_var = file.get_var()
	if diamond_var != null:
		diamond = diamond_var
		
	var addpersec_var = file.get_var()
	if addpersec_var != null:
		addpersec = addpersec_var
			
	var level_var = file.get_var()
	if level_var != null:
		level = level_var
		
	var currentLife_var = file.get_var()
	if currentLife_var != null:
		currentLife = currentLife_var
		
	var maxLife_var = file.get_var()
	if maxLife_var != null:
		maxLife = maxLife_var
	
	var config_var = file.get_var()
	config =  dict_to_inst(config_var) if config_var != null else preload_config.new()
	
	file.close()
	
func _process(_delta):
	$GoldValue.text = str(gold) #Change the text to the current gold every frame.	
	_toggleCpcItem()
	$DiamondValue.text = str(diamond)
	_toggleCpsItem()
	
func _toggleCpcItem():		
	$MenuBoutique/CPC1.disabled = gold < config.CPCRequirement
	$MenuBoutique/CPC2.disabled = gold < config.CPCRequirement2
	$MenuBoutique/CPC3.disabled = gold < config.CPCRequirement3
	$MenuBoutique/CPC4.disabled = gold < config.CPCRequirement4
	$MenuBoutique/CPC5.disabled = gold < config.CPCRequirement5	
		
func _toggleCpsItem():
	$MenuBoutique/CPS1.disabled = diamond < config.CPSRequirement
	$MenuBoutique/CPS2.disabled = diamond < config.CPSRequirement2
	$MenuBoutique/CPS3.disabled = diamond < config.CPSRequirement3
	$MenuBoutique/CPS4.disabled = diamond < config.CPSRequirement4
	$MenuBoutique/CPS5.disabled = diamond < config.CPSRequirement5
						
func _input(event):
	if (event is InputEventKey and not event.is_echo()):
		if event.pressed and event.keycode == KEY_ESCAPE:
			$MenuBoutique.visible = !$MenuBoutique.visible
			
func _on_Timer_timeout():
	gold += addpersec #After the Timer resets, add the add per second to the gold.
	updateLevel(addpersec)	
	$BossLife.value = currentLife
		
func _on_CPC1_pressed():
	if gold >= config.CPCRequirement:
		gold -= config.CPCRequirement
		config.CPCRequirement = round(config.CPCRequirement * 1.4)
		add = add + 1 #Add CPC
		var msg = str("+1 CPC [", config.CPCRequirement, " GOLD]")
		$MenuBoutique/CPC1.text = msg #Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)
		displayBought($MenuBoutique/BoughtCPC, msg)

func _on_CPC2_pressed():
	if gold >= config.CPCRequirement2:
		gold -= config.CPCRequirement2
		config.CPCRequirement2 = round(config.CPCRequirement2 * 1.3)
		add = add + 5 #Add CPC
		var msg = str("+5 CPC [", config.CPCRequirement2, " GOLD]")
		$MenuBoutique/CPC2.text = msg#Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)
		displayBought($MenuBoutique/BoughtCPC, msg)
	
func _on_CPC3_pressed():
	if gold >= config.CPCRequirement3:
		gold -= config.CPCRequirement3
		config.CPCRequirement3 = round(config.CPCRequirement3 * 1.2)
		add = add + 20 #Add CPC
		var msg = str("+20 CPC [", config.CPCRequirement3, " GOLD]")
		$MenuBoutique/CPC3.text = msg #Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)
		displayBought($MenuBoutique/BoughtCPC, msg)

func _on_CPC4_pressed():
	if gold >= config.CPCRequirement4:
		gold -= config.CPCRequirement4
		config.CPCRequirement4 = round(config.CPCRequirement4 * 1.1)
		add = add + 125 #Add CPC
		var msg = str("+125 CPC [", config.CPCRequirement4, " GOLD]")
		$MenuBoutique/CPC4.text = msg #Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)		
		displayBought($MenuBoutique/BoughtCPC, msg)
	
func _on_CPC5_pressed():
	if gold >= config.CPCRequirement5:
		gold -= config.CPCRequirement5
		config.CPCRequirement5 = config.CPCRequirement5
		add = add + 500 #Add CPC
		var msg = str("+500 CPC [", config.CPCRequirement5, " GOLD]")
		$MenuBoutique/CPC5.text = msg #Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)	
		displayBought($MenuBoutique/BoughtCPC, msg)
		
func _on_CPS1_pressed():
	if diamond >= config.CPSRequirement:
		diamond -= config.CPSRequirement
		config.CPSRequirement = round(config.CPSRequirement * 1.4)
		addpersec = addpersec + 1 #Add CPS.
		var msg = str("+1 CPS [", config.CPSRequirement, " DIAMOND]") 
		$MenuBoutique/CPS1.text = msg#Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)
		displayBought($MenuBoutique/BoughtCPS, msg)

func _on_CPS2_pressed():
	if diamond >= config.CPSRequirement2:
		diamond -= config.CPSRequirement2
		config.CPSRequirement2 = round(config.CPSRequirement2 * 1.3)
		addpersec = addpersec + 5 #Add CPS.
		var msg = str("+5 CPS [", config.CPSRequirement2, " DIAMOND]")
		$MenuBoutique/CPS2.text = msg # Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)
		displayBought($MenuBoutique/BoughtCPS, msg)

func _on_CPS3_pressed():
	if gold >= config.CPSRequirement3:
		gold -= config.CPSRequirement3
		config.CPSRequirement3 = round(config.CPSRequirement3 * 1.2)
		addpersec = addpersec + 20 #Add CPS.
		var msg = str("+20 CPS [", config.CPSRequirement3, " DIAMOND]") 
		$MenuBoutique/CPS3.text = msg#Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)
		displayBought($MenuBoutique/BoughtCPS, msg)

func _on_CPS4_pressed():
	if gold >= config.CPSRequirement4:
		gold -= config.CPSRequirement4
		config.CPSRequirement4 = round(config.CPSRequirement4 * 1.1)
		addpersec = addpersec + 125 #Add CPS.
		var msg = str("+125 CPS [", config.CPSRequirement4, " DIAMOND]")
		$MenuBoutique/CPS4.text = msg #Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)
		displayBought($MenuBoutique/BoughtCPS, msg)

func _on_CPS5_pressed():
	if gold >= config.CPSRequirement5:
		gold -= config.CPSRequirement5
		config.CPSRequirement5 = config.CPSRequirement5
		addpersec = addpersec + 500 #Add CPS.
		var msg = str("+500 CPS [", config.CPSRequirement5, " DIAMOND]")
		$MenuBoutique/CPS5.text = msg #Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)	
		displayBought($MenuBoutique/BoughtCPS, msg)
	
func displayBought(bought, text):
	bought.text = text
	var original_position = bought.position
	for i in range(30):
		bought.position.y -= 3
		await get_tree().create_timer(0.05).timeout
	bought.text = ""
	bought.position = original_position

func _on_button_monster_button_down():
	Input.set_custom_mouse_cursor(config.epee_onclick)
	
	gold += add # Replace with function body.   
	
	var particles = particles_scene.instantiate()
	add_child(particles)        
	particles.particle_finished.connect(_particle_finished.bind(particles))
	particles.restart()  
	
	updateLevel(add)	
	$Monster/HitSound.play()		
	$BossLife.value = currentLife
	
	_toggleCpcItem()
	_toggleCpsItem()
	
func _particle_finished(particle):
	remove_child(particle)
	
func _on_button_monster_button_up():
	Input.set_custom_mouse_cursor(config.epee_cursor)
	
func updateLevel(add):	
	currentLife -= add	
	if currentLife <= 0:
		diamond += add
		level += 1
		maxLife = round(maxLife*level)
		currentLife = maxLife		
		$BossLife.max_value = maxLife
		
		if config.levels.any(func(lvl): return lvl.level == level):
			$Background.texture = config.levels[level-1]["bg"]
			$Monster.texture = config.levels[level-1]["mob"]
		else:
			var rng = RandomNumberGenerator.new()
			var random_level = rng.randf_range(0, 13)		
			$Background.texture = config.levels[random_level]["bg"]
			$Monster.texture = config.levels[random_level]["mob"]
		
	$Level.text = "Level " + str(level) + "\n" + str(currentLife) + "/" + str(maxLife)
			
func _on_logo_boutique_button_pressed():
	$MenuBoutique.visible = !$MenuBoutique.visible

func _on_main_menu_button_pressed():
	await _saveSave()
	get_tree().change_scene_to_file("res://MainMenu.tscn") 
	
func _saveSave():
	if withSave == false:
		return
		
	var file = FileAccess.open("res://save.txt", FileAccess.READ_WRITE)
	file.store_var(gold)
	file.store_var(diamond)
	file.store_var(add)
	file.store_var(addpersec)
	file.store_var(level)
	file.store_var(currentLife)		
	file.store_var(maxLife)
	file.store_var(inst_to_dict(config))
	file.close()
	
# Sauvegarde à la fermeture
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		await _saveSave()
		get_tree().quit() 
