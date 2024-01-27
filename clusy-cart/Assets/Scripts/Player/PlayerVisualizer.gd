extends Sprite2D

var playerSprite : Sprite2D = null
var blinkTimer : Timer = null
var leftPart : CPUParticles2D = null
var rightPart : CPUParticles2D = null
#var boostParticles : GPUParticles2D = null
@export var DeathParticles : PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	playerSprite = self
	blinkTimer = $BlinkTimer
	leftPart = $LeftDrigtingParticles
	rightPart = $RightDriftingParticles
	#boostParticles = $BoostParticles
	#boostParticles.emitting = false
	
	Globals.player_boosting_state_changed.connect(PlayerBoostingStateChanged)
	Globals.game_init_everything.connect(on_game_init_everything)

#Start or stop the blinking 
func PlayerSwitchesFromBeingHit(starting:bool):
	if starting:
		blinkTimer.start()
		playerSprite.visible = false
	else:
		blinkTimer.stop()
		playerSprite.visible = true

func BlinkTimerEnded():
	playerSprite.visible = not playerSprite.visible
	
func ChangeDrift(drift:bool):
	leftPart.emitting = drift
	rightPart.emitting = drift

#######GLOBAL SIGNALS#######

func PlayerDeath():
	var newParticles = DeathParticles.instantiate()
	newParticles.global_position = global_position
	Globals.add_new_spawnable_to_pool.emit(newParticles)
	playerSprite.visible = false

func PlayerBoostingStateChanged(isBoosting : bool):
	#boostParticles.emitting = isBoosting
	pass
func on_game_init_everything():
	blinkTimer.stop()
	#boostParticles.emitting = false
	playerSprite.visible = true
