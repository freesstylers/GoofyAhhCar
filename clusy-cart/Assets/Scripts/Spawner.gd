extends Node2D
class_name Spawner

@export var PointsStackers : Array[Node]

@export var NPC : PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	PointsStackers = get_children()
	spawn()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	for n in get_child_count():	
		var spawned = NPC.instantiate()
		var aux = PointsStackers[n].duplicate()
		Globals.add_child(spawned)
		spawned.add_child(aux)
		spawned.setReady()
	

	#spawned.setReady()
	#Crear un NPC
	#Asignarle sus puntos
	pass
