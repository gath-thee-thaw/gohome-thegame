extends Area2D


var destination = Vector2()

var maxX = 987
var minX = 42
var maxY = 580
var minY = 23

export var speed := 300
var stopingDistance = 5

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
	
	

func setDestination():
	destination.x = rand_range(minX, maxX)
	destination.y = rand_range(minY, maxY)




func _on_enemy1_body_entered(body):
	setDestination()
