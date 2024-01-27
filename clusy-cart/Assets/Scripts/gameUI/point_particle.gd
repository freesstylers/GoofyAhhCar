extends Label

@export var InitialDir : Vector2
@export_range(0, 500, 0.1) var InitialVel : float
@export var Gravity : Vector2
@export var AngleRange : float
@export var TimeToLive : float

var amount : float
var t = 0.0
var vel : Vector2

var rng

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "+{0}".format([amount])
	
	rng = RandomNumberGenerator.new()
	var angle = rng.randf_range(-AngleRange, AngleRange)
	vel = InitialDir.rotated(deg_to_rad(angle)) * InitialVel
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t += delta
	if(t >= TimeToLive):
		queue_free()
		pass
	else:
		movement(delta)
		pass
	pass


func movement(delta):
	set_position(position + (vel * delta))
	
	vel += Gravity * delta
	pass
