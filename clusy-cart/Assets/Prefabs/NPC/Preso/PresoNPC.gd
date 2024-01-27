class_name PresoNPC
extends NPC

@export_category("Interval Min Max")
@export var min :float = 1
@export var max :float = 5

var canMove = true
var timeWaitingInterval : Vector2 = Vector2()
var timer : Timer = null

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(togle_move)
	var waitTime = randf_range(min, max)
	timer.start(waitTime)

func move(delta):
	if canMove:
		super.move(delta)
		

func togle_move():
	canMove = not canMove
