extends Area2D

var speed = 200
var kSpeed = 200
onready var player = get_parent().find_node("Player")
var bullet = load("res://scenes/Bullets/bulletEnenmy.tscn")
var stopingDistance = 20
var xStopingDistance = 200

var flip
var timer
export var waitSeconds = 0.4

var health = 3

func _ready():
	timer = waitSeconds

var direction1 = null
func _process(delta):
	
	var xDist = player.position.x - position.x
	var yDist = player.position.y - position.y
	
	if xDist < xStopingDistance and xDist > -xStopingDistance:
		xDist = 0
	if yDist < stopingDistance and yDist > -stopingDistance:
		yDist = 0
	
	direction1 = Vector2(
		xDist,
		yDist
	)
	
	if xDist == 0 and yDist == 0:
		$AnimationPlayer.play("RESET")
		_Timer(delta)
	
	if direction1.length() > 1.0:
		direction1 = direction1.normalized()
	position += direction1 * speed * delta
	$AnimationPlayer.play("Run")
	
	if direction1.length() == 0:
		$AnimationPlayer.play("RESET")
#	var distamce = player.position.y - position.y
#	if(distamce < 0):
#		distamce *= -1
#	if distamce <= stopingDistance:
#		speed = 0
#		$AnimationPlayer.play("RESET")
#		_Timer(delta)
#	else:
#		speed = kSpeed

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
	$gunSparksParticles.set_emitting(true)
	$gunSound.play()
	Global.camera.add_trauma(0.3)
	var bul = bullet.instance()
	bul.position = $gun/spawnPoint.global_position
	get_tree().root.add_child(bul)
	bul.playerFlip = flip
	
func _Timer(var delta):
	timer -= delta
	if(timer < 0):
		Shoot()
		timer = waitSeconds
		
func damage(var num):
	health -= num
	if(health <= 0):
		Global.enemies -= 1
		Global.set_enemyNumber()
		queue_free()
