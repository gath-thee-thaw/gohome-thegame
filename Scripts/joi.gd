extends TouchScreenButton

func _input(event):
	if event is InputEventScreenDrag or event is InputEventScreenTouch:
		global_position = event.position

