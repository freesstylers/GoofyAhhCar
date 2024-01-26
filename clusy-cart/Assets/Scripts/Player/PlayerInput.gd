extends Node2D

func _input(event):
	#Did the player just press a key
	if event is InputEventMouseButton and event.pressed:
		#Move right key
		if event.position.x > get_viewport_rect().size.x / 2 :
			Globals.player_input.emit(true,true)
		#Move left key
		else:
			Globals.player_input.emit(false,true)
	#Did the player just released either the right or left key
	elif event is InputEventMouseButton and not event.pressed:
		Globals.player_input.emit(false,false)
