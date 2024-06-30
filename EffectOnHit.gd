extends GPUParticles2D

func _ready():
	pass 

func _process(delta):
	global_position = get_global_mouse_position()

signal particle_finished
func _on_finished():
	particle_finished.emit()
