class_name GameManager
extends Node

var Experience = 0
var ExpNextLevel = 0
var Level = 0



func NextLevelCalc():
	return (Level * 10) + 5

# Called when the node enters the scene tree for the first time.
func _init():
	ExpNextLevel = NextLevelCalc()
	Globals.exp_gain.connect(expGain)

func _ready():
	Globals.GameMan = self

func expGain(exp : float):
	Experience += exp
	if(Experience >= ExpNextLevel):
		Level += 1
		Experience -= ExpNextLevel
		ExpNextLevel = NextLevelCalc()
		Globals.level_up.emit()
		pass
		
	Globals.exp_update.emit()
	pass
