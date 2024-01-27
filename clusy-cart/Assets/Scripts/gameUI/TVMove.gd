extends TextureRect

@export var maxRotation : float = 0.05
@export var maxTime : float = 1.0
@export var rotationSpeed : float = 0.2

var timer = 0.0
var dir = 1

func _process(delta):
	if dir == 1:
		if rotation>=maxRotation:
			dir*=-1
	else:
		if rotation<=-maxRotation:
			dir*=-1
			
	rotation+=rotationSpeed*delta*dir
