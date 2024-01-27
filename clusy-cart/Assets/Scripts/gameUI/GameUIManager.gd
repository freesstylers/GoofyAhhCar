extends Control

@export var LevelUpMenu : Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.level_up.connect(levelUp)
	LevelUpMenu.visible = false
	LevelUpMenu.WakeUp()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	pass
	
	
	
func levelUp():
	LevelUpMenu.visible = true
	get_tree().paused = true
	pass
