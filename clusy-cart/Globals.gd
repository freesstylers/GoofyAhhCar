extends Node

###################CONSTANTS###################
const WINDOW_BASE_SIZE = Vector2(1280,1280)
var RNG = RandomNumberGenerator.new()
var ThePlayer : Player = null
var MAX_PLAYER_LIFE : int = 100
var GameMan : GameManager = null

#Gameplay loop
signal game_init_everything()
signal game_start_playing()
signal game_over(playerDead : bool)

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
signal hp_update(currentHP : int)

signal npc_hit(whichNPC : NPCType)
enum NPCType {
	CIVIL,
	CICLISTA,
	ABUELA,
	CANGREJO,
	PRESO,
	CANINO
}
