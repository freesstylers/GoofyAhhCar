extends Control

@export var Rect : Control
@export var MinAngle : float
@export var MaxAngle : float
@export var MaxSpeed : float
@export var Accel : float
@export var Decel : float

var accelerating = false;
var speed = 0.0;


func _ready():
	#Rect.pivot_offset.y = Rect.size.x / 2.0
	Rect.rotation = MinAngle
	pass
	
func _input(event):
	if event.is_action_pressed("Accelerate"):
		accelerating = true;
	elif event.is_action_released("Accelerate"):
		accelerating = false;
	pass

func _process(delta):
	if accelerating and speed < MaxSpeed:
		speed += Accel * get_process_delta_time();
		speed = clamp(speed, 0, MaxSpeed)
	elif not accelerating and speed > 0:
		speed -= Decel * get_process_delta_time();
		speed = clamp(speed, 0, MaxSpeed)
	
	Rect.rotation_degrees = lerp(MinAngle, MaxAngle, speed / MaxSpeed)
	
	print("speed: {0} || angle: {1}".format([speed, Rect.rotation]))
	
	pass
