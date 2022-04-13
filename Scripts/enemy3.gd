extends Area2D

var speed = 200
var kSpeed = 200
onready var player = get_parent().find_node("Player")
var bullet = load("res://scenes/bullet2.tscn")
var stopingDistance = 10


func _process(delta):
	var direction = Vector2(
		0,
		player.position.y - position.y
	)
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	position += direction * speed * delta
	
	var distamce = player.position.y - position.y
	if(distamce < 0):
		distamce *= -1
	if distamce <= stopingDistance:
		speed = 0
	else:
		speed = kSpeed
