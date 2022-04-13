extends Area2D

onready var bigCircle = $BigCircle
onready var smallCircle = $BigCircle/SmallCircle

onready var maxDistance = $CollisionShape2D.shape.radius

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(bigCircle.global_position)
		if not touched:
			if distance < maxDistance:
				touched = true
		else:
			smallCircle.position = Vector2(0, 0)
			touched = false

func _process(delta):
	if touched:
		smallCircle.global_position = get_global_mouse_position()
		smallCircle.position = bigCircle.position + (smallCircle.position - bigCircle.position).clamped(maxDistance)

func getVelo():
	var joyVelo = Vector2(0,0)
	joyVelo.x = smallCircle.position.x/ maxDistance
	joyVelo.y = smallCircle.position.y/ maxDistance
	return joyVelo
