class_name Config

@export var CPCRequirement := 20 
@export var CPCRequirement2 := 150 
@export var CPCRequirement3 := 1400 
@export var CPCRequirement4 := 12000
@export var CPCRequirement5 := 200000 

@export var CPSRequirement := 5 
@export var CPSRequirement2 := 25 
@export var CPSRequirement3 := 100
@export var CPSRequirement4 := 625
@export var CPSRequirement5 := 2500 

const levels := [
{
	"level": 1, 
	"bg": "Levels/Level1",
	"mob1": preload("res://Resources/MONSTRES/Loup 2.png"), 
	"mob2": preload("res://Resources/MONSTRES/Loup 1.png"),
	"mob3": preload("res://Resources/MONSTRES/Grizzly 2.png"), 
	"boss": preload("res://Resources/MONSTRES/BOSS 1.png"),
	"mob_life": 10,
	"boss_life": 978 
}, 
{
	"level": 2, 
	"bg": "Levels/Level1",
	"mob1": preload("res://Resources/MONSTRES/Nature 1.png"), 
	"mob2": preload("res://Resources/MONSTRES/Druide 1.png"), 
	"mob3": preload("res://Resources/MONSTRES/Druide 2.png"),
	"boss": preload("res://Resources/MONSTRES/Orc 1.png"), 
	"mob_life": 28,
	"boss_life": 6000
},
{
	"level": 3, 
	"bg": "Levels/Level1",
	"mob1": preload("res://Resources/MONSTRES/Truc 1.png"), 
	"mob2": preload("res://Resources/MONSTRES/Trool 2.png"), 
	"mob3": preload("res://Resources/MONSTRES/Troll 1.png"),
	"boss": preload("res://Resources/MONSTRES/BOSS 1.png"), 
	"mob_life": 47,
	"boss_life": 36254
},
{
	"level": 4, 
	"bg": "Levels/Level1",
	"mob1": preload("res://Resources/Images/CHARACTER/mob4.png"), 
	"mob2": preload("res://Resources/Images/CHARACTER/mob5.png"), 
	"mob3": preload("res://Resources/Images/CHARACTER/mob6.png"),
	"boss": preload("res://Resources/Images/CHARACTER/boss2.png"), 
	"mob_life": 70,
	"boss_life": 198532
},
{
	"level": 5, 
	"bg": "Levels/Level1",
	"mob1": preload("res://Resources/Images/CHARACTER/mob4.png"), 
	"mob2": preload("res://Resources/Images/CHARACTER/mob5.png"), 
	"mob3": preload("res://Resources/Images/CHARACTER/mob6.png"),
	"boss": preload("res://Resources/Images/CHARACTER/boss2.png"), 
	"mob_life": 140,
	"boss_life": 856896
},
]

const max_stage = 10
const boss_stage = 50

const epee_cursor := preload("res://Resources/Images/epee100.png")
const epee_onclick := preload("res://Resources/Images/epee_onclick.png")

@export var vol_music := 100	
@export var vol_click := 100 
@export var window_mode := DisplayServer.WINDOW_MODE_WINDOWED
