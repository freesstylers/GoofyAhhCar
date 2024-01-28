extends Control

@export var LevelUpMenu : Control
@export var GameOverMenu : Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.level_up.connect(levelUp)
	Globals.game_over.connect(gameOver)
	LevelUpMenu.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	#if event.is_action_pressed("Accelerate"):
		#Globals.hp_change.emit(-100)
	pass
	
	
	
func levelUp():
	LevelUpMenu.visible = true
	LevelUpMenu.WakeUp()
	get_tree().paused = true
	pass
	
func gameOver(dead : bool):
	GameOverMenu.visible = true
	GameOverMenu.TurnOn(dead)
	get_tree().paused = true
	pass
