class_name NPC
extends CharacterBody2D

@export var points : int = 100
@export var bonus :String = ""
@export var speed := 300.0

var goTo: Node2D = null
var pointBehaviour : PointsB = null

func _init():
	pointBehaviour = $PointsBehaviour as PointsB
	goTo = pointBehaviour.get_actual_point()

func is_min_dist(d):
	return position.distance_to(goTo.position) <= d
	
	
func move(delta):
	var dir = (goTo.position - position).normalized()
	position = position + dir*speed*delta
	
	if is_min_dist(1):
		goTo = pointBehaviour.get_next_point()


func _process(delta):
	move(delta)

func die():
	pass

func spawn():
	pass
