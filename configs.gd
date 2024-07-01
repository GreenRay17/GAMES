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
{"level":1, "bg":preload("res://Resources/Images/FONDS/fond1.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob1.png")},
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
{"level":13, "bg":preload("res://Resources/Images/FONDS/fond2.jpg"), "mob":preload("res://Resources/Images/CHARACTER/mob14.png")},
]

const epee_cursor := preload("res://Resources/Images/epee100.png")
const epee_onclick := preload("res://Resources/Images/epee_onclick.png")

@export var vol_music := 100	
@export var vol_click := 100 
@export var window_mode := DisplayServer.WINDOW_MODE_WINDOWED
