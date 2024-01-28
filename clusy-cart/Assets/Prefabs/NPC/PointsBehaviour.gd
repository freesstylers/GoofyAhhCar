extends Node
class_name PointsB

@export var points : Array[Node]
var actualPoint : int = 0

var timer = null

func _ready():
	points = get_children()	
	timer = Timer.new()
	pass

func get_actual_point():
	return points[actualPoint]

func get_next_point():
	actualPoint = (actualPoint + 1) % points.size()
	return get_actual_point() 

