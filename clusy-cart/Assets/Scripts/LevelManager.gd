extends Node

@export var spawningPosition : Node2D = null
@export var player : Player = null
@export var levelTime : int = 60

var numStartingEnemies : int = 0
var numEnemiesLeft : int = 0
var endTimer : Timer = null

func _ready():
	endTimer = $LevelTimer
	var my_group_members = get_tree().get_nodes_in_group("enemy")
	numStartingEnemies = my_group_members.size()
	numEnemiesLeft = numStartingEnemies

func StartGame():
	player.global_position = spawningPosition.global_position
	endTimer.start()
	Globals.game_start_playing.emit()

func EndTimerFinished():
	Globals.player_lost.emit()

func EnemyKilled():
	numEnemiesLeft = numEnemiesLeft - 1
	if numEnemiesLeft <= 0:
		Globals.player_won.emit()

func on_game_init_everything():
	numEnemiesLeft = numStartingEnemies
