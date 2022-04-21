extends Area2D

export var knockback = 50
var isknockback = false

var speed = 200
var kSpeed = 200
onready var player = get_parent().find_node("Player")
var bullet = load("res://scenes/Bullets/bulletEnenmy.tscn")
var stopingDistance = 20
var xStopingDistance = 200

var flip
var timer
export var waitSeconds = 0.4

var health = 10

var dead_animation = load("res://scenes/Enemies/EnemyGunDead.tscn")
var current_xpos

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

	#flip
	if(player.position.x > position.x):
		if(flip):
			apply_scale(Vector2(-1,1))
			flip = false
			knockback = -(abs(knockback))
			
	if(player.position.x < position.x):
		if(!flip):
			apply_scale(Vector2(-1,1))
			flip = true
			knockback = abs(knockback)
			
	if isknockback:
		global_position.x = lerp(global_position.x, current_xpos + knockback, 0.6)
		isknockback = false


func Shoot():
	$gun/gunSparksParticles.set_emitting(true)
	$gun/gunSound.play()
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


func damage(var num, var pos):
	$ImpactAnimationPlayer.stop(true)
	$ImpactAnimationPlayer.play("Hit")
	var bp = Global.blood_splash.instance()
	Global.camera.add_trauma(0.02)
	add_child(bp)
	bp.global_position = pos
	isknockback = true
	current_xpos = global_position.x
	health -= num
	if(health <= 0):
		var da = dead_animation.instance()
		get_parent().add_child(da)
		da.global_position = global_position - Vector2(0,-20)
		if flip:
			da.set_scale(Vector2(-1,1))
		else:
			da.set_scale(Vector2(1,1))
		Global.enemies -= 1
		Global.set_enemyNumber()
		queue_free()
