extends Control

const preload_config = preload("res://configs.gd")
var config = null
const particles_scene = preload("res://EffectOnHit.tscn")

const withSave := false

var gold = 0
var diamond = 0
var add = 1
var addpersec = 0
var addperboss = 1

var level = 1
var current_stage = 1
var current_life = 10
var max_life = 10

func _ready():	
	await _getSettings()
	await _getSave()
	
	manageLevel(0)
	
	# TODo à fixer on peut etre sur un boss
	$Monster.texture = config.levels[level-1]["mob1"]	 
	
func _getSettings():
	var file = FileAccess.open("res://settings.txt", FileAccess.READ)
	
	#$Backgrounds/BackgroundLevel1/BackgroundMusic.volume_db = file.get_var()
	file.get_var() # NE PAS SUPPRIMER
	$Monster/HitSound.volume_db = file.get_var()
	# TODO gerer ça avant
	DisplayServer.window_set_mode(file.get_var())

func _getSave():
	if withSave == false:
		config = preload_config.new()
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
		
	var current_stage_var = file.get_var()
	if current_stage_var != null:
		current_stage = current_stage_var
		
	var current_life_var = file.get_var()
	if current_life_var != null:
		current_life = current_life_var
		
	var max_life_var = file.get_var()
	if max_life_var != null:
		max_life = max_life_var
	
	var config_var = file.get_var()
	config =  dict_to_inst(config_var) if config_var != null else preload_config.new()
	
	file.close()
	
#func _process(_delta):
	#manageLevel(addpersec)
	
func _get_highNumberDisplay(valeur):
	var suffix = ""
	
	if valeur > pow(10,36)-1:
		suffix = "U"		
	elif valeur > pow(10,33)-1:
		suffix = "D"
	elif valeur > pow(10,30)-1:
		suffix = "N"		
	elif valeur > pow(10,27)-1:
		suffix = "O"
	elif valeur > pow(10,24)-1:
		suffix = "Sp"		
	elif valeur > pow(10,21)-1:
		suffix = "Sx"		
	elif valeur > pow(10,18)-1:
		suffix = "Qi"		
	elif valeur > pow(10,15)-1:
		suffix = "Qa"		
	elif valeur > pow(10,12)-1:
		suffix = "T"
	elif valeur > pow(10,9)-1:
		suffix = "B"		
	elif valeur > pow(10,6)-1:
		suffix = "M"
	elif valeur > pow(10,3)-1:
		suffix = "K"
		
	var valeur_str = str(valeur)
	var concatened_value = valeur_str[0];
	if suffix != "":
		concatened_value += "."
	if len(valeur_str) > 1:
		concatened_value += valeur_str[1]		
	if len(valeur_str) > 2:
		concatened_value += valeur_str[2]
	if len(valeur_str) > 3:
		concatened_value += valeur_str[3]
		
	return concatened_value+suffix

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
	manageLevel(addpersec)	
		
func _on_CPC1_pressed():
	if gold >= config.CPCRequirement:
		gold -= config.CPCRequirement
		config.CPCRequirement = round(config.CPCRequirement * 1.4)
		add = add + 1 #Add CPC
		var msg = str("+1 CPC [", config.CPCRequirement, " GOLD]")
		$MenuBoutique/CPC1.text = msg #Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)
		textHover($MenuBoutique/BoughtCPC.duplicate(), msg)

func _on_CPC2_pressed():
	if gold >= config.CPCRequirement2:
		gold -= config.CPCRequirement2
		config.CPCRequirement2 = round(config.CPCRequirement2 * 1.3)
		add = add + 5 #Add CPC
		var msg = str("+5 CPC [", config.CPCRequirement2, " GOLD]")
		$MenuBoutique/CPC2.text = msg#Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)
		textHover($MenuBoutique/BoughtCPC.duplicate(), msg)
	
func _on_CPC3_pressed():
	if gold >= config.CPCRequirement3:
		gold -= config.CPCRequirement3
		config.CPCRequirement3 = round(config.CPCRequirement3 * 1.2)
		add = add + 20 #Add CPC
		var msg = str("+20 CPC [", config.CPCRequirement3, " GOLD]")
		$MenuBoutique/CPC3.text = msg #Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)
		textHover($MenuBoutique/BoughtCPC.duplicate(), msg)

func _on_CPC4_pressed():
	if gold >= config.CPCRequirement4:
		gold -= config.CPCRequirement4
		config.CPCRequirement4 = round(config.CPCRequirement4 * 1.1)
		add = add + 125 #Add CPC
		var msg = str("+125 CPC [", config.CPCRequirement4, " GOLD]")
		$MenuBoutique/CPC4.text = msg #Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)		
		textHover($MenuBoutique/BoughtCPC.duplicate(), msg)
	
func _on_CPC5_pressed():
	if gold >= config.CPCRequirement5:
		gold -= config.CPCRequirement5
		config.CPCRequirement5 = config.CPCRequirement5
		add = add + 500 #Add CPC
		var msg = str("+500 CPC [", config.CPCRequirement5, " GOLD]")
		$MenuBoutique/CPC5.text = msg #Combine multiple strings to show the required clicks.
		$CPC.text = str("CPC:", add)	
		textHover($MenuBoutique/BoughtCPC.duplicate(), msg)
		
func _on_CPS1_pressed():
	if diamond >= config.CPSRequirement:
		diamond -= config.CPSRequirement
		config.CPSRequirement = round(config.CPSRequirement * 1.4)
		addpersec = addpersec + 1 #Add CPS.
		var msg = str("+1 CPS [", config.CPSRequirement, " DIAMOND]") 
		$MenuBoutique/CPS1.text = msg#Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)
		textHover($MenuBoutique/BoughtCPS.duplicate(), msg)

func _on_CPS2_pressed():
	if diamond >= config.CPSRequirement2:
		diamond -= config.CPSRequirement2
		config.CPSRequirement2 = round(config.CPSRequirement2 * 1.3)
		addpersec = addpersec + 5 #Add CPS.
		var msg = str("+5 CPS [", config.CPSRequirement2, " DIAMOND]")
		$MenuBoutique/CPS2.text = msg # Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)
		textHover($MenuBoutique/BoughtCPS.duplicate(), msg)

func _on_CPS3_pressed():
	if gold >= config.CPSRequirement3:
		gold -= config.CPSRequirement3
		config.CPSRequirement3 = round(config.CPSRequirement3 * 1.2)
		addpersec = addpersec + 20 #Add CPS.
		var msg = str("+20 CPS [", config.CPSRequirement3, " DIAMOND]") 
		$MenuBoutique/CPS3.text = msg#Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)
		textHover($MenuBoutique/BoughtCPS.duplicate(), msg)

func _on_CPS4_pressed():
	if gold >= config.CPSRequirement4:
		gold -= config.CPSRequirement4
		config.CPSRequirement4 = round(config.CPSRequirement4 * 1.1)
		addpersec = addpersec + 125 #Add CPS.
		var msg = str("+125 CPS [", config.CPSRequirement4, " DIAMOND]")
		$MenuBoutique/CPS4.text = msg #Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)
		textHover($MenuBoutique/BoughtCPS.duplicate(), msg)

func _on_CPS5_pressed():
	if gold >= config.CPSRequirement5:
		gold -= config.CPSRequirement5
		config.CPSRequirement5 = config.CPSRequirement5
		addpersec = addpersec + 500 #Add CPS.
		var msg = str("+500 CPS [", config.CPSRequirement5, " DIAMOND]")
		$MenuBoutique/CPS5.text = msg #Combine multiple strings to show the required clicks.
		$CPS.text = str("CPS:", addpersec)	
		textHover($MenuBoutique/BoughtCPS.duplicate(), msg)
	
func textHover(node, text):
	node.text = text
	var original_position = node.position
	for i in range(30):
		node.position.y -= 3
		await get_tree().create_timer(0.05).timeout
	node.text = ""
	node.position = original_position
	remove_child(node)

func _on_button_monster_button_down():
	Input.set_custom_mouse_cursor(config.epee_onclick)
	
	var particles = particles_scene.instantiate()
	add_child(particles)        
	particles.particle_finished.connect(_particle_finished.bind(particles))
	particles.restart()  
	
	$Monster/HitSound.play()		
	manageLevel(add)	
	
func updateCpcCps():
	$GoldValue.text = _get_highNumberDisplay(gold) 
	_toggleCpcItem()
	$DiamondValue.text = _get_highNumberDisplay(diamond)
	_toggleCpsItem()	
	
func _particle_finished(particle):
	remove_child(particle)
	
func _on_button_monster_button_up():
	Input.set_custom_mouse_cursor(config.epee_cursor)
	
var mob = 1
func manageLevel(add):	
	current_life -= add	
	
	if current_life <= 0:	
		updateLevel()
	
	$MobLifePercent.value = current_life
	$MobLifePercent.max_value = max_life
	
	$Level.text = "Level " + str(level) + "\n" + str(current_stage) + "/" + str(config.max_stage)
	$MobLife.text = str(current_life) + "/" + str(max_life)
	
	updateCpcCps()	 
	
func updateLevel():	
		current_stage += 1	
		gold += add 		
		
		# mob 
		if current_stage < config.boss_stage:			
			mob += 1 		
			
			$Monster.texture = config.levels[level-1]["mob" + str(mob-1)]	 	
			max_life = config.levels[level-1]["mob_life"]			
			
			var new_earned = $EarnedGold.duplicate();
			add_child(new_earned)
			textHover(new_earned, "+"+ str(add))
			
		# on va tuer le boss
		elif current_stage == config.boss_stage:
			#mob = 1
			$Monster.texture = config.levels[level-1]["boss"]	
			max_life = config.levels[level-1]["boss_life"]
			
		# on a tué le boss		
		if current_stage > config.max_stage:
			# loop sur 5 levels
			if level < 5:
				level += 1	
			else:
				level = 1
				
			current_stage = 1		
			diamond += addperboss			
			
			var new_earned = $EarnedDiamond.duplicate();
			add_child(new_earned)
			textHover(new_earned, "+"+ str(addperboss))
			
			get_node(config.levels[level-2]["bg"]).visible = false
			get_node(config.levels[level-1]["bg"]).visible = true
			
		# switch entre les mob1/2/3
		if mob == 4:
			mob = 1
		
		current_life = max_life		
		$MobLifePercent.max_value = max_life
		
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
	file.store_var(current_stage)
	file.store_var(current_life)		
	file.store_var(max_life)
	file.store_var(inst_to_dict(config))
	file.close()
	
# Sauvegarde à la fermeture
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		await _saveSave()
		get_tree().quit() 
