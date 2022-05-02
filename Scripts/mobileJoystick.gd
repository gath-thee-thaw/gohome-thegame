extends CanvasLayer

signal use_move_vector

var move_vector = Vector2(0,0)
var joystick_active = false

onready var maxDistance = $BigCircle.shape.radius
onready var smallCircle = $SmallCircle
onready var bigCircle = $BigCircle

onready var smallcircle_initpos


func _ready():
	smallcircle_initpos = smallCircle.position

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if bigCircle.is_pressed():
			move_vector = calculate_move_vector(event.position)
			joystick_active = true
			smallCircle.position = event.position
			#smallCircle.position = bigCircle.position + (smallCircle.position - bigCircle.position).clamped(maxDistance)
	
	if event is InputEventScreenTouch:
		if event.pressed ==false && joystick_active==true:
			joystick_active = false
			smallCircle.position = smallcircle_initpos
	
func _physics_process(_delta):
	
	if joystick_active:
		emit_signal("use_move_vector", move_vector)
	if joystick_active == false:
		emit_signal("use_move_vector", Vector2(0,0))
func calculate_move_vector(event_position):
	var texture_centre = bigCircle.position +Vector2(64,64)
	return (event_position - texture_centre)
