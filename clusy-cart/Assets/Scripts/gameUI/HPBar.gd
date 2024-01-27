extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = Globals.MAX_PLAYER_LIFE
	value = Globals.MAX_PLAYER_LIFE
	
	Globals.hp_update.connect(updateHP)
	pass

func updateHP(hp):
	value = hp
	pass
