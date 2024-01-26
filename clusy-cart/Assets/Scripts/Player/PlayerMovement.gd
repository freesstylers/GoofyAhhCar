extends RigidBody2D
class_name Player

@export var ACCELERATION := 1000.0
@export var MAX_SPEED := 400.0

@export var ANGULAR_ACCELERATION := 50.0
@export var MAX_ANGULAR_VELOCITY := 5.0  

#@export var ANGULAR_ANGLES := 5.0


#BOOST RELATED
var boostTimer : Timer = null
var driftingTimer : Timer = null
var boostAvailable : bool = false

#POWERUP RELATED
var betterHandling : bool = false

var turningRight : bool = false
var turningLeft : bool = false
var used_acceleration : float = 0
var used_andular_acceleration : float = 0

func _ready():
	boostTimer = $BoostTimer
	driftingTimer = $DriftingTimer
	
	Globals.ThePlayer = self
	Globals.player_input.connect(PlayerInput)
	Globals.player_death.connect(PlayerDeath)
	Globals.game_init_everything.connect(on_game_init_everything)
	used_acceleration = ACCELERATION
	used_andular_acceleration = ANGULAR_ACCELERATION
	
func _process(_delta):
	var steering_input = 0
	if turningRight:
		steering_input = 1.0
		#rotation = rotation + ((ANGULAR_ANGLES*(PI*2)/360)*_delta)
		#print(rotation)
	if turningLeft:
		steering_input = -1.0
		#rotation = rotation - ((ANGULAR_ANGLES*(PI*2)/360)*_delta)
		#print(rotation)

	# Rotate the body based on the steering input
	apply_torque(used_andular_acceleration * steering_input)
	if abs(angular_velocity) > MAX_ANGULAR_VELOCITY:
		set_angular_velocity(sign(angular_velocity) * MAX_ANGULAR_VELOCITY)
		#angular_velocity = sign(angular_velocity) * MAX_ANGULAR_VELOCITY
	
	#Accelerate towards the direction the player is facing
	var steering_direction = Vector2(1, 0).rotated(rotation)
	#steering_direction = Vector2(0,-1)
	if linear_velocity.length() > MAX_SPEED:
		linear_velocity = linear_velocity.normalized() * MAX_SPEED
	apply_force(steering_direction * used_acceleration)

func PlayerInput(right:bool, pressed:bool):
	#Input just pressed	
	if pressed:
		turningRight = right
		turningLeft = not right
	#Input just released
	else:
		if right and turningRight:
			turningRight = false
			driftingTimer.stop()
			if boostAvailable:
				StartBoosting()
		elif not right and turningLeft:
			turningLeft = false
			driftingTimer.stop()
			if boostAvailable:
				StartBoosting()
		else:
			turningRight = false
			turningLeft = false
			driftingTimer.stop()
			if boostAvailable:
				StartBoosting()

#Rotate the player so that it "bounces" away from the wall
func PlayerCollidedWithWall(wall:Node2D):
	linear_velocity = linear_velocity.bounce((Vector2((get_viewport().size/2)) - wall.global_position).normalized()) 
	look_at(global_position + linear_velocity)
	
func StartBoosting():
	boostTimer.start()
	Globals.player_boosting_state_changed.emit(true)
	
func StopBoosting():
	used_acceleration = ACCELERATION
	Globals.player_boosting_state_changed.emit(false)
	
func BoosReady():
	boostAvailable = true

#####GLOBAL SIGNALS#####

func PlayerDeath():
#	GlobalConstants.ThePlayer = null
#	queue_free()
	linear_velocity = Vector2(0,0)
	angular_velocity = 0
	used_acceleration = 0
	used_andular_acceleration = 0
	
func on_power_up_chosen(PowerUp : Globals.PowerUp):
	#match PowerUp:
		#Globals.PowerUp.BETTER_HANDLING:
			#used_andular_acceleration = BETTER_ANGULAR_ACCELERATION
	pass
			
func on_game_init_everything():
	used_acceleration = ACCELERATION
	used_andular_acceleration = ANGULAR_ACCELERATION
	rotation = 0
	boostAvailable = false
	#Position the player right in the middle of the screen
	var screen_size = get_viewport().size
	var center_screen = Vector2(screen_size.x / 2, screen_size.y / 2)
	self.global_position = center_screen
