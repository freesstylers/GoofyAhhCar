extends Control

@export var Rect : Control
@export var MinAngle : float
@export var MaxAngle : float


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
	
	var speed = Globals.ThePlayer.velocity
	var maxSpeed = 550
	
	Rect.rotation_degrees = lerp(MinAngle, MaxAngle, speed / 550)
	
	#print("speed: {0} || angle: {1}".format([speed, Rect.rotation]))
	
	pass
