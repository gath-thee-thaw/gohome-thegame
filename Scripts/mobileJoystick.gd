extends CanvasLayer

signal use_move_vector

var move_vector = Vector2(0,0)
var joystick_active = false

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton.is_pressed():
			move_vector = calculate_move_vector(event.position)
			joystick_active = true
			$SmallCircle.position = event.position
	
	if event is InputEventScreenTouch:
		if event.pressed ==false:
			joystick_active = false
			$SmallCircle.position = $TouchScreenButton.position+ Vector2(58,58)
	
func _physics_process(delta):
	if joystick_active:
		emit_signal("use_move_vector", move_vector)
	if joystick_active == false:
		emit_signal("use_move_vector", Vector2(0,0))
func calculate_move_vector(event_position):
	var texture_centre = $TouchScreenButton.position +Vector2(64,64)
	return (event_position - texture_centre)
	print(move_vector)
