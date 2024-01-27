extends Panel

enum Skills { MAX_SPEED, ACCEL, HANDLING, HP }

@export var hpButton : Button

func WakeUp():
	hpButton.visible = Globals.ThePlayer.currentLife < Globals.MAX_PLAYER_LIFE
	pass

func buttonPress(btn : int):
	
	var s : Skills
	s = btn
	
	
	match s:
		Skills.MAX_SPEED:
			
			pass
		Skills.ACCEL:
			
			pass
		Skills.HANDLING:
			
			pass
		Skills.HP:
			Globals.hp_change.emit(1)
			pass
	
	get_tree().paused = false
	visible = false
	pass
