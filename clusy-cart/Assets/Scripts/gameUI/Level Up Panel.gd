extends Panel

enum Skills { MAX_SPEED, ACCEL, HANDLING, HP }

@export var hpButton : Button

var ColorFade : Control

func WakeUp(fade):
	hpButton.visible = Globals.ThePlayer.currentLife < Globals.MAX_PLAYER_LIFE
	ColorFade = fade
	pass

func buttonPress(btn : int):
	get_tree().root.get_node("SceneManager/ButtonSFX").play()
	
	var s : Skills
	s = btn
	var pl = Globals.ThePlayer
	
	
	match s:
		Skills.MAX_SPEED:
			pl.engine_power += Globals.LEVEL_UP_MAX_VEL
			pass
		Skills.ACCEL:
			pl.accelThreshold -= Globals.LEVEL_UP_ACCEL
			pass
		Skills.HANDLING:
			pl.steering_angle += Globals.LEVEL_UP_HANDLING
			pass
		Skills.HP:
			Globals.hp_change.emit(Globals.MAX_PLAYER_LIFE / 2)
			pass
	
	get_tree().paused = false
	visible = false
	ColorFade.visible = false
	pass
