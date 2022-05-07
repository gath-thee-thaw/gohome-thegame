extends Area2D

onready var player = Global.player

var kSpeed = 200
var speed = 1000
var stopingDistance = 200
var yStoppingDist = -50
var canFollow = true
var flip

var health = 5
var rng = RandomNumberGenerator.new()

export var knockback = 50
var isknockback = false
var current_xpos

var canAttack = true
var destination
var nextEnemy
var isfollowingEnemy = false
var randX 
var randY
var followingEnemy

func _process(delta):
	if !is_instance_valid(followingEnemy):
		var xD = rand_range(stopingDistance, - stopingDistance)
		var yD = rand_range(yStoppingDist, - yStoppingDist)
		destination = player.position + Vector2(xD, yD)
	elif is_instance_valid(followingEnemy):
		if global_position.x > player.global_position.x:
			destination = followingEnemy.position + Vector2(randX, randY)
		else:
			
			destination = followingEnemy.position + Vector2(-randX, randY)
	
	

	var direction = Vector2(destination - position)

	if direction.length() > 1.0:
		direction = direction.normalized()
	position += direction * speed * delta
	
	var distamce = position.distance_to(destination)
	if distamce <= stopingDistance:
		speed = 0
	else:
		speed = kSpeed
		
	#flip
	if(player.global_position.x > global_position.x):
		knockback = -abs(knockback)
		if(flip):
			apply_scale(Vector2(-1,1))
			flip = false

	if(player.global_position.x < global_position.x):
		knockback = abs(knockback)
		if(!flip):
			apply_scale(Vector2(-1,1))
			flip = true

	if isknockback:
		global_position.x = lerp(global_position.x, current_xpos + knockback, 0.6)
		isknockback = false

func damage(var num, pos):
	$ImpactAnimationPlayer.stop(true)
	$ImpactAnimationPlayer.play("Hit")
	var bp = Global.blood_splash.instance()
	add_child(bp)
	bp.global_position = pos
	isknockback = true
	current_xpos = global_position.x
	health -= num
	if(health <= 0):
		Global.enemies -= 1
		Global.set_enemyNumber()
		queue_free()
		
		
		
		
		

func _on_enemy2_area_entered(area):
	if area.is_in_group("Player"):
		canFollow = false
	if area.is_in_group("enemyChase") and !is_instance_valid(followingEnemy):
		
		var distA = area.global_position.distance_to(player.position)
		var distB = global_position.distance_to(player.position)
		
		if distA >= distB:
			nextEnemy = area
		else:
			if !is_instance_valid(followingEnemy):
				randX = rand_range(stopingDistance, 10)
				randY = rand_range(yStoppingDist, - yStoppingDist)
				followingEnemy = area
				
				
				

	

func _on_enemy2_area_exited(area):
	if area.is_in_group("Player"):
		canFollow = true
