extends KinematicBody2D


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
	move_and_slide(speed * direction)
	
	var distamce = position.distance_to(destination)
	if distamce <= stopingDistance:
		setDestination()
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		setDestination()

func setDestination():
	destination.x = rand_range(minX, maxX)
	destination.y = rand_range(minY, maxY)
