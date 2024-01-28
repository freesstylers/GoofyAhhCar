extends Control

@export var LevelUpMenu : Control
@export var GameOverMenu : Control
@export var ColorFade : Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.level_up.connect(levelUp)
	Globals.game_over.connect(gameOver)
	LevelUpMenu.visible = false
	GameOverMenu.visible = false
	ColorFade.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	#if event.is_action_pressed("Accelerate"):
		#Globals.GameMan.TimeLeft = 0
	pass
	
func levelUp():
	LevelUpMenu.visible = true
	LevelUpMenu.WakeUp(ColorFade)
	get_tree().paused = true
	ColorFade.visible = true
	pass
	
func gameOver(dead : bool):
	GameOverMenu.visible = true
	GameOverMenu.TurnOn(dead)
	get_tree().paused = true
	ColorFade.visible = true
	pass
