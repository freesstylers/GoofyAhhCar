extends Node2D
class_name Spawner

@export var PointsStackers : Array[Node]

@export var NPC : Array[PackedScene]

@export var type : Globals.NPCType

var spawnerInitialSpawnProb = 0.5
var rng

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	PointsStackers = get_children()
	spawnReady()
	Globals.npc_hit.connect(spawnDesired)
		
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawnReady():
	var usedStackers : Array[int]
	var n = 0
	var totalSpawned = get_child_count() * spawnerInitialSpawnProb
	
	while n < totalSpawned:	
		var spawned = NPC.pick_random().instantiate()
		
		var randomRandy = rng.randi_range(0, get_child_count())
		
		if !usedStackers.has(randomRandy):
			usedStackers.append(randomRandy)
			var aux = PointsStackers[n].duplicate()
			
			#asignar int a PointsB de qué spawner le corresponde?
			Globals.add_child(spawned)
			spawned.add_child(aux)
			spawned.setReady()
			n+=1;
	pass

func spawnDesired(selected:Globals.NPCType):
	if selected == type:
		var timer = Timer.new()
		add_child(timer)
		timer.start(rng.randi_range (3,8))
		
		await timer.timeout

		var spawned = NPC.pick_random().instantiate()		
		var aux = PointsStackers.pick_random().duplicate()
		Globals.add_child(spawned)
		spawned.add_child(aux)
		spawned.setReady()
		
		timer.queue_free()
		pass
