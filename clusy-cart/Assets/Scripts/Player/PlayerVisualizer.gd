extends AnimatedSprite2D

var playerSprite : Sprite2D = null
var leftBoostingParticles : CPUParticles2D = null
var rightBoostingParticles : CPUParticles2D = null

func _ready():
	leftBoostingParticles = $LeftDrigtingParticles
	rightBoostingParticles = $RightDriftingParticles
	
	Globals.game_init_everything.connect(on_game_init_everything)
	Globals.kill_modifier_obtained.connect(on_kill_modifier_obtained)
	
func ChangeDrift(drift:bool):
	leftBoostingParticles.emitting = drift
	rightBoostingParticles.emitting = drift
	
###GLOBAL SIGNALS###
	
func on_game_init_everything():
	leftBoostingParticles.modulate = Color.WHITE
	rightBoostingParticles.modulate = Color.WHITE

func on_kill_modifier_obtained(modifier : Globals.KillModifier):
	match modifier:
		Globals.KillModifier.SpeedBoost:
			leftBoostingParticles.modulate = Color.YELLOW
			rightBoostingParticles.modulate = Color.YELLOW

		Globals.KillModifier.SpeedLoss:
			leftBoostingParticles.modulate = Color.GRAY
			rightBoostingParticles.modulate = Color.GRAY
