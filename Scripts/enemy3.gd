extends Area2D

var speed = 200
var kSpeed = 200
onready var player = get_parent().find_node("Player")
var bullet = load("res://scenes/bulletEnenmy.tscn")
var stopingDistance = 100

var flip
var timer
var waitSeconds = 1

func _ready():
	timer = waitSeconds

var direction1 = null
func _process(delta):
	
	direction1 = Vector2(
		0,
		player.position.y - position.y
	)
	
	if direction1.length() > 1.0:
		direction1 = direction1.normalized()
	position += direction1 * speed * delta
	
	var distamce = player.position.y - position.y
	if(distamce < 0):
		distamce *= -1
	if distamce <= stopingDistance:
		speed = 0
		_Timer(delta)
	else:
		speed = kSpeed
		
		
		
		
		 
	#flip
	if(player.position.x > position.x):
		if(flip):
			apply_scale(Vector2(-1,1))
			flip = false
	if(player.position.x < position.x):
		if(!flip):
			apply_scale(Vector2(-1,1))
			flip = true
	
func Shoot():
	var bul = bullet.instance()
	bul.position = $gun/spawnPoint.global_position
	get_tree().root.add_child(bul)
	bul.playerFlip = flip
	
func _Timer(var delta):
	timer -= delta
	if(timer < 0):
		Shoot()
		timer = waitSeconds
