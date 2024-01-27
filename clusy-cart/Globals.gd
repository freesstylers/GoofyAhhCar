extends Node

###################CONSTANTS###################
const WINDOW_BASE_SIZE = Vector2(1280,1280)
var ThePlayer : Player = null

#Gameplay loop
signal game_init_everything()
signal game_start_playing()
signal player_won()
signal player_lost()
