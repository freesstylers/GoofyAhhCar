extends Control

@export var LevelUpMenu : Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.level_up.connect(levelUp)
	LevelUpMenu.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event.is_action_pressed("Accelerate"):
		Globals.exp_gain.emit(1)
		pass
	pass
	
	
	
func levelUp():
	LevelUpMenu.visible = true
	get_tree().paused = true
	pass
