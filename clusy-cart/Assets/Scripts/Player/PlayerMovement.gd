extends CharacterBody2D
class_name Player

var imagen : Sprite2D = null

###########################################NUEVO SISTEMA
@export var wheel_base : float = 70  # Distance from front to rear wheel
@export var steering_angle : float = 15  # Amount that front wheel turns, in degrees

@export var steer_angle : float = 0.0
@export var engine_power : float = 800  # Forward acceleration force.

var acceleration : Vector2 = Vector2.ZERO
@export var friction : float = -0.9
@export var drag : float = -0.0015
@export var braking : float = -450
@export var max_speed_reverse : float = 250
@export var slip_speed : float = 400  # Speed where traction is reduced
@export var traction_fast : float = 0.1  # High-speed traction
@export var traction_slow : float = 0.7  # Low-speed traction
###############################################

var maxVelGotten : bool = false
var drifting : bool = false

func _ready():	
	Globals.ThePlayer = self
	Globals.game_init_everything.connect(on_game_init_everything)
	
func _process(_delta):
	pass
			
func get_input():
	var turn = 0
	if Input.is_action_pressed("right"):
		turn += 1
	if Input.is_action_pressed("left"):
		turn -= 1
	steer_angle = turn * steering_angle
	if Input.is_action_pressed("up"):
		#TODO SONIDO
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("back"):
		acceleration = transform.x * braking
	if Input.is_action_pressed("drift"):
		drifting = true
		$PlayerVisualizer.ChangeDrift(drifting)
	else:
		drifting = false		
		$PlayerVisualizer.ChangeDrift(drifting)
		
func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	
	var collision = move_and_collide(velocity*delta)
	if collision:
		#TODO SONIDO
		velocity = velocity.bounce(collision.get_normal())

func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	if velocity.length() < 260:
		friction_force *= 3
		if velocity.length() > 20:
			$PlayerVisualizer.ChangeDrift(true)
	else:
		if not drifting:
			$PlayerVisualizer.ChangeDrift(false)
	
	acceleration += drag_force + friction_force
	#Cuando llega a velocidad maxima hace sonido, y hasta que no vuelve a llegar no vuelve a sonar
	if acceleration.length() < 0.1:
		if not maxVelGotten: 
			#TODO SONIDO
			maxVelGotten = true
	else: 
		maxVelGotten = false
		
	
func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_angle) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if drifting:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = velocity.lerp(new_heading * velocity.length(), traction)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()

#####GLOBAL SIGNALS#####
			
func on_game_init_everything():
	#Position the player right in the middle of the screen
	var screen_size = get_viewport().size
	var center_screen = Vector2(screen_size.x / 2, screen_size.y / 2)
	self.global_position = center_screen


func _on_plusfriction_pressed():
	friction += 0.1


func _on_minusfriction_pressed():
	friction -= 0.1


func _on_minusdrag_pressed():
	drag-=0.001


func _on_plusdrag_pressed():
	drag+=0.001


func _on_minusengine_pressed():
	engine_power-=100


func _on_plusengine_pressed():
	engine_power+=100
