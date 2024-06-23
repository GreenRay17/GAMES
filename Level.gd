extends Label

var level = 1
var currentLife = 10
var maxLife = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	update(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update(add):	
	currentLife -= add	
	
	if currentLife <= 0:
		level += 1
		maxLife = round(maxLife*1.25)
		currentLife = maxLife
		
	text = str(currentLife) + "/" + str(maxLife)
	
