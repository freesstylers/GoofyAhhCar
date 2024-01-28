extends Control

@export var Rect : Control
@export var MinAngle : float
@export var MaxAngle : float
@export var MaxAngleRev : float


func _ready():
	#Rect.pivot_offset.y = Rect.size.x / 2.0
	Rect.rotation_degrees = MinAngle
	pass
	
func _input(event):
	#if event.is_action_pressed("Accelerate"):
		#accelerating = true;
	#elif event.is_action_released("Accelerate"):
		#accelerating = false;
	pass

func _process(delta):
	if(Globals.ThePlayer == null):
		return
	
	var speed = Globals.ThePlayer.velocity.length()
	
	var deg : float
	
	if(Globals.ThePlayer.reverse):
		deg = lerp(MinAngle, MaxAngleRev, speed / Globals.ThePlayer.max_speed_reverse)
		pass
	else:
		deg = lerp(MinAngle, MaxAngle, speed / 550)
		pass
		
	Rect.rotation_degrees = deg
	
	#print("speed: {0} || angle: {1}".format([speed, deg]))
	
	pass
