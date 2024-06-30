extends Control

const particles_scene = preload("res://EffectOnHit.tscn")

var score = 0
var diamant = 0
var add = 1
var addpersec = 1

var level = 1
var currentLife = 10
var maxLife = 10

var withSave = false

var mousepos = Vector2()

func _on_Timer_timeout():
	score += addpersec #After the Timer resets, add the add per second to the score.
	updateLevel(addpersec)	
	$ProgressBar.value = currentLife

func _process(_delta):
	$Score.text = str(score) #Change the text to the current score every frame.
	$Diamant.text = str(diamant)
	
var CPCRequirement = 20 #Clicks required to upgrade Clicks Per Click
var CPCRequirement2 = 150 #Clicks required to upgrade Clicks Per Click #2
var CPCRequirement3 = 1400 #Clicks required to upgrade Clicks Per Click #3
var CPCRequirement4 = 12000 #Clicks required to upgrade Clicks Per Click #4
var CPCRequirement5 = 200000 #Clicks required to upgrade Clicks Per Click #5
var CPSRequirement = 5 #Clicks required to upgrade Clicks Per Second
var CPSRequirement2 = 25 #Clicks required to upgrade Clicks Per Second #2
var CPSRequirement3 = 100 #Clicks required to upgrade Clicks Per Second #3
var CPSRequirement4 = 625 #Clicks required to upgrade Clicks Per Second #4
var CPSRequirement5 = 2500 #Clicks required to upgrade Clicks Per Second #5

func displayBought(text):
	$Bought.text = text
	var original_position = $Bought.position.y	
	for i in range(30):
		$Bought.position.y -= 3
		await get_tree().create_timer(0.05).timeout
	$Bought.text = ""
	$Bought.position.y = original_position
	
	
func _on_CPC1_pressed():
	if score >= CPCRequirement:
		score -= CPCRequirement
		CPCRequirement = round(CPCRequirement * 1.4)
		add = add + 1 #Add CPC
		var msg = str("+1 CPC [", CPCRequirement, "]")
		$VBoxContainer/CPC1.text = msg #Combine multiple strings to show the required clicks.
		$Label3.text = str("CPC:", add)
		displayBought(msg)
	


func _on_CPS1_pressed():
	if diamant >= CPSRequirement:
		diamant -= CPSRequirement
		CPSRequirement = round(CPSRequirement * 1.4)
		addpersec = addpersec + 1 #Add CPS.
		var msg = str("+1 CPS [", CPSRequirement, "]") 
		$VBoxContainer/CPS1.text = msg#Combine multiple strings to show the required clicks.
		$Label2.text = str("CPS:", addpersec)
		displayBought(msg)


func _on_CPS2_pressed():
	if diamant >= CPSRequirement2:
		diamant -= CPSRequirement2
		CPSRequirement2 = round(CPSRequirement2 * 1.3)
		addpersec = addpersec + 5 #Add CPS.
		var msg = str("+5 CPS [", CPSRequirement2, "]")
		$VBoxContainer/CPS2.text = msg # Combine multiple strings to show the required clicks.
		$Label2.text = str("CPS:", addpersec)
		displayBought(msg)


func _on_CPC2_pressed():
	if score >= CPCRequirement2:
		score -= CPCRequirement2
		CPCRequirement2 = round(CPCRequirement2 * 1.3)
		add = add + 5 #Add CPC
		var msg = str("+5 CPC [", CPCRequirement2, "]")
		$VBoxContainer/CPC2.text = msg#Combine multiple strings to show the required clicks.
		$Label3.text = str("CPC:", add)
		displayBought(msg)


func _on_CPS3_pressed():
	if score >= CPSRequirement3:
		score -= CPSRequirement3
		CPSRequirement3 = round(CPSRequirement3 * 1.2)
		addpersec = addpersec + 20 #Add CPS.
		var msg = str("+20 CPS [", CPSRequirement3, "]") 
		$VBoxContainer/CPS3.text = msg#Combine multiple strings to show the required clicks.
		$Label2.text = str("CPS:", addpersec)
		displayBought(msg)


func _on_CPC3_pressed():
	if score >= CPCRequirement3:
		score -= CPCRequirement3
		CPCRequirement3 = round(CPCRequirement3 * 1.2)
		add = add + 20 #Add CPC
		var msg = str("+20 CPC [", CPCRequirement3, "]")
		$VBoxContainer/CPC3.text = msg #Combine multiple strings to show the required clicks.
		$Label3.text = str("CPC:", add)
		displayBought(msg)


func _on_CPS4_pressed():
	if score >= CPSRequirement4:
		score -= CPSRequirement4
		CPSRequirement4 = round(CPSRequirement4 * 1.1)
		addpersec = addpersec + 125 #Add CPS.
		var msg = str("+125 CPS [", CPSRequirement4, "]")
		$VBoxContainer/CPS4.text = msg #Combine multiple strings to show the required clicks.
		$Label2.text = str("CPS:", addpersec)
		displayBought(msg)


func _on_CPC4_pressed():
	if score >= CPCRequirement4:
		score -= CPCRequirement4
		CPCRequirement4 = round(CPCRequirement4 * 1.1)
		add = add + 125 #Add CPC
		var msg = str("+125 CPC [", CPCRequirement4, "]")
		$VBoxContainer/CPC4.text = msg #Combine multiple strings to show the required clicks.
		$Label3.text = str("CPC:", add)		
		displayBought(msg)


func _on_CPS5_pressed():
	if score >= CPSRequirement5:
		score -= CPSRequirement5
		CPSRequirement5 = CPSRequirement5
		addpersec = addpersec + 500 #Add CPS.
		var msg = str("+500 CPS [", CPSRequirement5, "]")
		$VBoxContainer/CPS5.text = msg #Combine multiple strings to show the required clicks.
		$Label2.text = str("CPS:", addpersec)	
		displayBought(msg)


func _on_CPC5_pressed():
	if score >= CPCRequirement5:
		score -= CPCRequirement5
		CPCRequirement5 = CPCRequirement5
		add = add + 500 #Add CPC
		var msg = str("+500 CPC [", CPCRequirement5, "]")
		$VBoxContainer/CPC5.text = msg #Combine multiple strings to show the required clicks.
		$Label3.text = str("CPC:", add)	
		displayBought(msg)

func _on_button_pressed_monster():
	score += add # Replace with function body.   
	var particles = particles_scene.instantiate()
	add_child(particles)        
	particles.restart()
	updateLevel(add)	
	$ClickMusic.play()		
	$ProgressBar.value = currentLife
	
func _getSettings():
	var file = FileAccess.open("res://settings.txt", FileAccess.READ)
	
	$BackgroundMusic.volume_db = file.get_var()
	$ClickMusic.volume_db = file.get_var()

func _ready():	
	await _getSave()
	await _getSettings()
	
	updateLevel(0)
	$ProgressBar.value = currentLife
	$ProgressBar.max_value = maxLife
	$ProgressBar.step = 1
	

# Sauvegarde à la fermeture
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		await _saveSave()
		get_tree().quit() #
	
func _getSave():	
	if withSave == false:
		return
	var file = FileAccess.open("res://save.txt", FileAccess.READ)
	
	var score_var = file.get_var()
	if score_var != null:
		score = score_var
		
	var add_var = file.get_var()
	if add_var != null:
		add = add_var		
		
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
	
	file.close()
	
func _saveSave():
	if withSave == false:
		return
		
	var file = FileAccess.open("res://save.txt", FileAccess.READ_WRITE)
	file.store_var(score)
	file.store_var(add)
	file.store_var(addpersec)
	file.store_var(level)
	file.store_var(currentLife)		
	file.store_var(maxLife)
	file.close()
	
const levels = [{"level":1, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob1.png")},
{"level":2, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob3.png")},
{"level":3, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob4.png")},
{"level":4, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob5.png")},
{"level":5, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob6.png")},
{"level":6, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob7.png")},
{"level":7, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob8.png")},
{"level":8, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob9.png")},
{"level":9, "bg":preload("res://Resources/Images/FONDS/fond2.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob10.png")},
{"level":10, "bg":preload("res://Resources/Images/FONDS/fond2.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob11.png")},
{"level":11, "bg":preload("res://Resources/Images/FONDS/fond2.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob12.png")},
{"level":12, "bg":preload("res://Resources/Images/FONDS/fond2.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob13.png")},
{"level":13, "bg":preload("res://Resources/Images/FONDS/fond2.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob14.png")},]

func updateLevel(add):	
	currentLife -= add	
	if currentLife <= 0:
		diamant += add
		level += 1
		maxLife = round(maxLife*level)
		currentLife = maxLife		
		$ProgressBar.max_value = maxLife
		
		if levels.any(func(lvl): return lvl.level == level):
			$Background.texture = levels[level-1]["bg"]
			$Monster.texture = levels[level-1]["mob"]
		else:
			var rng = RandomNumberGenerator.new()
			var random_level = rng.randf_range(0, 13)		
			$Background.texture = levels[random_level]["bg"]
			$Monster.texture = levels[random_level]["mob"]
		
	$Level.text = "Level " + str(level) + "\n" + str(currentLife) + "/" + str(maxLife)
				
var epee_cursor = preload("res://Resources/Images/epee100.png")
var epee_onclick = preload("res://Resources/Images/epee_onclick.png")
func _input(event):
	if (event is InputEventKey and not event.is_echo()):
		if event.pressed and event.keycode == KEY_ESCAPE:
			$VBoxContainer.visible = !$VBoxContainer.visible
					
	if event is InputEventMouseButton:
		if event.pressed == false:
				Input.set_custom_mouse_cursor(epee_cursor)
		else:
				Input.set_custom_mouse_cursor(epee_onclick)
			
func _on_control_button_down():
	$VBoxContainer.visible = !$VBoxContainer.visible

func _on_main_menu_button_pressed():
	await _saveSave()
	get_tree().change_scene_to_file("res://MainMenu.tscn") 
