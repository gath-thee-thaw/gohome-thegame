extends TouchScreenButton

onready var big = get_parent().get_parent()
onready var small = get_parent()

var touched = false

func _input(event):
	if event is InputEventScreenDrag or event is InputEventScreenTouch:
		if not touched:
			touched = true
		else:
			touched = false
			small.position = Vector2(0, 0)
		
		
		
func _process(delta):
	if touched:
		small.global_position = get_global_mouse_position()
		small.global_position = big.global_position + (small.global_position - big.global_position).clamped(80)

	
