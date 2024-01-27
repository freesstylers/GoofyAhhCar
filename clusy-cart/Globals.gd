extends Node

###################CONSTANTS###################
const WINDOW_BASE_SIZE = Vector2(1280,1280)
var RNG = RandomNumberGenerator.new()
var ThePlayer : Player = null
var GameMan : GameManager = null

#Gameplay loop
signal game_init_everything()
signal game_start_playing()
signal player_won()
signal player_lost()

signal kill_modifier_obtained(modifier : KillModifier)

enum KillModifier {
	SpeedBoost,
	SpeedLoss
}

signal exp_gain(exp : float, points : float)
signal exp_update()
signal level_up()
signal change_face(num:int)
signal hp_change(num:int)
signal game_over(playerDead : bool)
