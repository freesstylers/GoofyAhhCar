extends Label

func _on_plusengine_pressed():
	text = str(text.to_float() + 100)


func _on_minusengine_pressed():
	text = str(text.to_float() - 100)
