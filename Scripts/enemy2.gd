extends Area2D

onready var player = get_parent().find_node("Player")
var kSpeed = 200
var speed = 1000
var stopingDistance = 50

func _process(delta):
	var direction = Vector2(
		player.position.x - position.x,
		player.position.y - position.y
	)
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	position += direction * speed * delta
	
	
	var distamce = position.distance_to(player.position)
	if distamce <= stopingDistance:
		speed = 0
	else:
		speed = kSpeed
