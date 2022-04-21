extends Area2D

onready var player = get_parent().find_node("Player")
var kSpeed = 200
var speed = 1000
var stopingDistance = 50
var canFollow = true
var flip

var health = 5
var rng = RandomNumberGenerator.new()

func _process(delta):
	var direction = Vector2(
	player.position - position)

	if direction.length() > 1.0:
		direction = direction.normalized()
	position += direction * speed * delta
	
	var distamce = position.distance_to(player.position)
	if distamce <= stopingDistance:
		speed = 0
	else:
		speed = kSpeed
	   
	if(player.position.x > position.x):
		if(flip):
			apply_scale(Vector2(-1,1))
			flip = false
	if(player.position.x < position.x):
		if(!flip):
			apply_scale(Vector2(-1,1))
			flip = true

func damage(var num, pos):
	Global.camera.add_trauma(0.01)
	var bp = Global.blood_splash.instance()
	add_child(bp)
	bp.global_position = pos
	
	health -= num
	if(health <= 0):
		Global.enemies -= 1
		Global.set_enemyNumber()
		queue_free()

func _on_enemy2_area_entered(area):
	if area.is_in_group("Player"):
		canFollow = false

func _on_enemy2_area_exited(area):
	if area.is_in_group("Player"):
		canFollow = true
