extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.exp_update.connect(expUpdate)
	max_value = Globals.GameMan.ExpNextLevel
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func expUpdate():
	value = Globals.GameMan.Experience
	pass
	
func levelUp():
	value = Globals.GameMan.Experience
	max_value = Globals.GameMan.ExpNextLevel
	pass
