extends Node

###################CONSTANTS###################
const WINDOW_BASE_SIZE = Vector2(1280,1280)

enum PowerUp {
	#Movement
	BETTER_HANDLING,
	#Shooting
	PLUS_1_MORE_BULLET_PER_SECOND,
	PLUS_10_PERCENT_CACENCE,
	PLUS_20_PERCENT_CHANCE_TO_SHOOT_TWO_BULLETS,
	PLUS_20_PERCENT_TO_SHOOT_SPECIAL_BULLET,
	#Explosion
	PLUS_20_PERCENT_EXPLOSION_SIZE,
	PLUS_20_PERCENT_CHANCE_SPAWN_EXPLOSION_ON_BULLET_KILL,
	PLUS_20_PERCENT_CHANCE_SPAWN_EXPLOSION_ON_LIGHTNING_KILL,
	EXPLOSION_ON_PLAYER_HIT,
	EXPLOSION_ON_LIFE_PICK_UP,
	#Lightning
	PLUS_1_LIGHTNING_PER_SECOND,
	LIGHTNING_EXPLOSION_ON_PLAYER_DAMAGED,
	#Boosting
	BOOST_QUICKER,
	INVENCIBILITY_ON_BOOST,
	PLUS_50_PERCENT_CHANCE_QUADRUPLE_SHOT_WHILE_BOOSTING,
	
	NUM_POWERUPS
}

#const PowerUpIconImage = [
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
	#preload("res://Art/Sprites/PowerUpIcons/Prueba.png"),
#]

const PowerUpMessage = [
	"BETTER HANDLING",
	#Shooting
	"PLUS 1 MORE BULLET PER_SECOND",
	"PLUS 10 PERCENT CACENCE",
	"PLUS 20 PERCENT CHANCE TO SHOOT TWO_BULLETS",
	"PLUS 20 PERCENT TO SHOOT SPECIAL BULLET",
	#Explosion
	"PLUS 20 PERCENT EXPLOSION SIZE",
	"PLUS 20 PERCENT CHANCE SPAWN EXPLOSION ON BULLET KILL",
	"PLUS 20 PERCENT CHANCE SPAWN EXPLOSION ON LIGHTNING KILL",
	"EXPLOSION ON PLAYER_HIT",
	"EXPLOSION ON LIFE_PICK_UP",
	#Lightning
	"PLUS 1 LIGHTNING PER_SECOND",
	"LIGHTNING EXPLOSION ON PLAYER DAMAGED",
	#Boosting
	"BOOST QUICKER",
	"INVENCIBILITY ON BOOST",
	"PLUS 50 PERCENT CHANCE QUADRUPLE SHOT WHILE BOOSTING",
]

#SHOOTING
const PlayerDefaultCadence = 4
const DoubleBulletShotRadiansFromCenter = PI/7

const GameTime : int = 180
const PlayerStartingLifes : int = 3
const SlowMotionTimeScale = 0.05

const EnemyMovementSpeed : float = 100
const BoostLength : float = 1

var ThePlayer : Player = null

func GetRandomOutcome(p : float) -> bool:
	return randf() < p

###################SIGNALS###################

#Gameplay loop
signal game_init_everything()
signal game_start_playing()
signal player_won()
signal player_death()

#Player movement
signal player_input(right:bool, pressed:bool)
signal player_boosting_state_changed(isBoosting:bool)
#Player Lifes
signal player_lifes_changed(new_value)
signal player_got_hit()
#Player powerups
signal player_was_offered_powerups(leftPowerUp: Globals.PowerUp, rightPowerUp : Globals.PowerUp)
signal player_chose_powerup(powerUpChosen : Globals.PowerUp)

#Spawnables
signal add_new_spawnable_to_pool(newNode:Node2D)
signal destoy_all_spawnables()

#Explosion related
signal spawn_explosion(position : Vector2)
signal enemy_killed_by_bullet(position:Vector2)
signal enemy_killed_by_lightning(position:Vector2)
