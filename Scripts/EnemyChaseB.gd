extends Area2D

onready var player = Global.player

var kSpeed = 200
var speed = 200
var stoppingDist = 100

var rndX = 200
var rndY = 200
var followTarget

func _process(delta):
	print($Timer.time_left)
	if $Timer. time_left <= 0:
		_follow(player.position, delta)
	else:
		_follow(followTarget, delta)
		
	
	


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemyChase") and $Timer. time_left <= 0:
		var dist = global_position.distance_squared_to(player.position)
		var distB = area.global_position.distance_squared_to(player.position)
		
		if dist <= distB:
			return
		if $Timer.time_left <= 0:
			$Timer.start()
			followTarget = _randPos()


func _on_Area2D_area_exited(area):
	pass
		

func _follow(var target, var delta):
	var direction = Vector2(target - position)

	if direction.length() > 1.0:
		direction = direction.normalized()
	position += direction * speed * delta
	
	if global_position.distance_to(target) < stoppingDist:
		speed = 0
	else: 
		speed = kSpeed

	
func _randPos():
	var randX = rand_range(rndX, -rndX)
	var randY = rand_range(rndY, -rndY)
	return (global_position + Vector2(randX, randY))


func _on_Timer_timeout():
	pass # Replace with function body.
