extends Panel

@export var Title : Label
@export var TotalPoints : Label
@export var MaxLevel : Label
@export var MaxSpeed : Label
@export var Accel : Label
@export var Handling : Label
@export var NPCsKilled : Label
@export var TimesCrashed : Label

func TurnOn(dead : bool):
	
	if dead:
		Title.text = "You LOSE!!"
		pass
	else:
		Title.text = "Time's UP!!"
		pass
		
	var gm = Globals.GameMan
	var pl = Globals.ThePlayer
		
	TotalPoints.text = str(gm.Points)
	MaxLevel.text = str(gm.Level)
	MaxSpeed.text = str("%.2f" % pl.getMaxVelocity())
	Accel.text = str(pl.accelThreshold)
	Handling.text = str(pl.steering_angle)
	NPCsKilled.text = str(gm.TotalDead)
	TimesCrashed.text = str(pl.timesCrashed)
	
	pass
	
func menu():
	get_tree().root.get_node("SceneManager").backToMenu()
	pass
