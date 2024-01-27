extends Label


# Called when the node enters the scene tree for the first time.
func _init():
	Globals.exp_gain.connect(expGain)
	text = str(Globals.GameMan.Points)
	pass # Replace with function body.


func expGain(exp : float, points : float):
	text = str(Globals.GameMan.Points)
	pass
