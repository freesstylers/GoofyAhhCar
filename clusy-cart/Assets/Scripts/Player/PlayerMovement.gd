class_name Player
extends CharacterBody2D

###########################################NUEVO SISTEMA
@export var wheel_base : float = 70  # Distance from front to rear wheel
@export var steering_angle : float = 15  # Amount that front wheel turns, in degrees
@export var drifting_angle : float = 45  # Amount that front wheel turns, in degrees

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

@export var accelThreshold : float = 260.0
###############################################

var used_engine_power : float = engine_power
var maxVelGotten : bool = false
var drifting : bool = false

var BounceSoundPlayer : AudioStreamPlayer = null
var MaxVelAchievedSoundPlayer : AudioStreamPlayer = null
var DriftSoundPlayer : AudioStreamPlayer = null
var InitDriftSoundPlayer : AudioStreamPlayer = null
var HornSoundPlayer : AudioStreamPlayer = null

var currentLife : int

var reverse = false

var timesCrashed = 0

func _ready():	
	timesCrashed = 0
	currentLife = Globals.MAX_PLAYER_LIFE
	
	Globals.ThePlayer = self
	
	Globals.change_face.emit(0)
	BounceSoundPlayer = $BounceSoundPlayer
	MaxVelAchievedSoundPlayer = $MaxVelAchievedSoundPlayer
	DriftSoundPlayer = $DriftSoundPlayer
	InitDriftSoundPlayer = $InitDriftSoundPlayer
	HornSoundPlayer = $HornSoundPlayer
	
	Globals.game_init_everything.connect(on_game_init_everything)
	Globals.kill_modifier_obtained.connect(on_kill_modifier_obtained)
	Globals.hp_change.connect(ChangeLife)
			
func get_input():
	var turn = 0
	if Input.is_action_pressed("right"):
		turn = 1
	if Input.is_action_pressed("left"):
		turn = -1
	#Angulo de giro	
	if drifting:
		steer_angle = turn * (drifting_angle*(2*PI)/360)
	else:
		steer_angle = turn * (steering_angle*(2*PI)/360)
		
	if Input.is_action_pressed("up"):
		#TODO SONIDO
		acceleration = transform.x * used_engine_power
	if Input.is_action_pressed("back"):
		acceleration = transform.x * braking
	if Input.is_action_pressed("drift"):
		drifting = true
		$PlayerVisualizer.ChangeDrift(drifting)
	else:
		drifting = false		
		$PlayerVisualizer.ChangeDrift(drifting)
		
	if Input.is_action_just_pressed("drift"):
		InitDriftSoundPlayer.play()
	if Input.is_action_just_released("drift"):
		InitDriftSoundPlayer.stop()
		DriftSoundPlayer.play()
		
	if Input.is_action_just_released("horny"):
		HornSoundPlayer.play()
		
func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	
	var collision = move_and_collide(velocity*delta)
	if collision:
		var vel = velocity.length()
		#Solo haces el sonidito si tienes una velocidad "significativa"
		if(vel > max_speed_reverse*2):
			timesCrashed += 1
			Globals.hp_change.emit(-10)
			
			if(not BounceSoundPlayer.playing):
				BounceSoundPlayer.play()
				Globals.change_face.emit(2)
		velocity = velocity.bounce(collision.get_normal())

func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	if velocity.length() < accelThreshold:
		friction_force *= 3
		if velocity.length() > 20:
			$PlayerVisualizer.ChangeDrift(true)
	else:
		if not drifting:
			$PlayerVisualizer.ChangeDrift(false)
	
	acceleration += drag_force + friction_force
	#Cuando llega a cierta velocidad hace sonido, y hasta que no vuelve a llegar no vuelve a sonar
	if acceleration.length() < 10:
		if not maxVelGotten and velocity.length() > 20: 
			Globals.change_face.emit(1)
			MaxVelAchievedSoundPlayer.play()
			maxVelGotten = true
	else: 
		maxVelGotten = false	
	
func getMaxVelocity():
	return log(engine_power) / log(1.3)
	
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
		reverse = false
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
		reverse = true
	rotation = new_heading.angle()

func ChangeLife(lifeDelta : float):
	currentLife = clampi(currentLife + lifeDelta, 0, 100)
	Globals.hp_update.emit(currentLife)
	if currentLife == 0:
		Globals.game_over.emit(true)
		
func _on_plusfriction_pressed():
	friction += 0.1

func _on_minusfriction_pressed():
	friction -= 0.1


func _on_minusdrag_pressed():
	drag-=0.001


func _on_plusdrag_pressed():
	drag+=0.001


func _on_minusengine_pressed():
	used_engine_power-=100


func _on_plusengine_pressed():
	used_engine_power+=100

func on_speed_timer_ended():
	used_engine_power = engine_power

#####GLOBAL SIGNALS####

func on_game_init_everything():
	used_engine_power = engine_power
	currentLife = Globals.MAX_PLAYER_LIFE

func on_kill_modifier_obtained(modifier : Globals.KillModifier):
	match modifier:
		Globals.KillModifier.SpeedBoost:
			used_engine_power = engine_power * 2
			$SpeedTimer.start()
			
		Globals.KillModifier.SpeedLoss:
			used_engine_power = engine_power / 2
			$SpeedTimer.start()
