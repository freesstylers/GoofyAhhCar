extends Node2D

const level1 = preload("res://Assets/Scenes/Maps/Mapa 2.tscn")
const level2 = preload("res://Assets/Scenes/Maps/Prueba Tileset Ignacio.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("loadLevel", loadLevel)

	pass # Replace with function body.	

func loadLevel():
	var rng = RandomNumberGenerator.new()
	var level = rng.randi_range(0,1)

	$CurrentScene.get_child(0).queue_free()
		
	if level == 0:
		$CurrentScene.add_child(level1.instantiate())
		pass
	elif level == 1:
		$CurrentScene.add_child(level2.instantiate())
		pass

func startGame(level: int):
	$TransitionScreen.transition()
	#currentLevel = level
