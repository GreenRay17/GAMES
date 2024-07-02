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
	"mob1": preload("res://Resources/Images/CHARACTER/mob1.png"), 
	"mob2": preload("res://Resources/Images/CHARACTER/mob2.png"),
	"mob3": preload("res://Resources/Images/CHARACTER/mob3.png"), 
	"boss": preload("res://Resources/Images/CHARACTER/boss1.png"),
	"mob_life": 1,
	"boss_life": 1 #10,978
}, 
{
	"level":2, 
	"bg": "Levels/Level2",
	"mob1": preload("res://Resources/Images/CHARACTER/mob4.png"), 
	"mob2": preload("res://Resources/Images/CHARACTER/mob5.png"), 
	"mob3": preload("res://Resources/Images/CHARACTER/mob6.png"),
	"boss": preload("res://Resources/Images/CHARACTER/boss2.png"), 
	"mob_life": 26,
	"boss_life": 6000
},
]

const epee_cursor := preload("res://Resources/Images/epee100.png")
const epee_onclick := preload("res://Resources/Images/epee_onclick.png")

@export var vol_music := 100	
@export var vol_click := 100 
@export var window_mode := DisplayServer.WINDOW_MODE_WINDOWED
