class_name NPC
extends Node2D

@export var points : int = 100
@export var bonus :String = ""
@export var speed := 300.0
@export var distanceThreshold := 5
@export var npcType : Globals.NPCType = Globals.NPCType.CIVIL

var goTo: Node2D = null
var pointBehaviour : PointsB = null

func setReady():
	pointBehaviour = get_child(get_child_count()-1)
	goTo = pointBehaviour.get_actual_point()
	global_position = goTo.global_position


func is_min_dist(d):
	return global_position.distance_to(goTo.global_position) <= d
	
	
func move(delta):
	var dir = (goTo.global_position - global_position).normalized()
	global_position = global_position + dir*speed*delta
	look_at(goTo.global_position)
	if is_min_dist(distanceThreshold):
		goTo = pointBehaviour.get_next_point()
		finish_move()

func finish_move():
	pass

func _process(delta):
	if goTo != null:
		move(delta)

func die():
	queue_free()

func spawn():
	pass

func on_collision(other):
	if other.is_in_group("player"):
		Globals.npc_hit.emit(npcType)
		die()
		#goTo = null
		#get_parent().remove_child(self)
		#other.add_child(self)
		#position = Vector2(0,0)
		#
		#var animLength : float = 2
		#var randomDir = randf() * 2*PI
		#var dirToMove : Vector2 = Vector2(1,0).rotated(randomDir)
		#var localTween : Tween = create_tween()
		#localTween.set_parallel(true)
		#localTween.tween_property(self, "position", Vector2(Globals.WINDOW_BASE_SIZE.x,0), animLength)
		#localTween.tween_property(self, "scale", Vector2(3,3), animLength)
		#localTween.tween_callback(self.queue_free).set_delay(animLength)
