extends Area2D


var destination = Vector2()

var maxX = 987
var minX = 42
var maxY = 580
var minY = 23

export var speed := 300
var stopingDistance = 5

var flip
var health = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	setDestination()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction := Vector2(
		destination.x - position.x,
		destination.y - position.y
	)
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	position += direction * delta * speed
	
	var distamce = position.distance_to(destination)
	if distamce <= stopingDistance:
		setDestination()
	
	if(destination.x > position.x):
		if(flip):
			apply_scale(Vector2(-1,1))
			flip = false
	if(destination.x < position.x):
		if(!flip):
			apply_scale(Vector2(-1,1))
			flip = true

func setDestination():
	destination.x = rand_range(minX, maxX)
	destination.y = rand_range(minY, maxY)

func _on_enemy1_body_entered(body):
	setDestination()

func damage(var num, pos):
	health -= num
	if(health <= 0):
		Global.enemies -= 1
		Global.set_enemyNumber()
		queue_free()
