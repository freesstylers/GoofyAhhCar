extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = Globals.GameMan.TimeLeft
	
	text = "{0}:{1}".format(["%02d" % int(t / 60), "%02d" % fmod(t, 60)])
	pass
