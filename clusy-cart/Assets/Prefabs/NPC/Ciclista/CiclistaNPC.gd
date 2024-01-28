class_name CiclistaNPC
extends NPC

var canMove : bool = true

func move(delta):
	if not canMove:
		return
	super.move(delta)

func  finish_move():
	canMove = false
	var z = $Zigzag as ZigZag
	z.realocate = true
	var dist = z.position.distance_to(Vector2(0,0))
	var t = dist/speed
	
	var tween = get_tree().create_tween()
	tween.tween_property(z, "position", Vector2(0,0), t)
	tween.tween_callback(start_move)
	
func start_move():
	canMove = true
	var z = $Zigzag as ZigZag
	z.realocate = false

func die():
	super.die()
	canMove = false
	($Zigzag as ZigZag).StopZigZag()
