extends Area2D

var playerFlip
var speed = 1500

var maxDist = 300
var spawnPoint

var dir


func _ready():
	spawnPoint = global_position
	$AnimatedSprite.play("default")

	
func _process(delta):
	#position += playerDirection * playerSpeed + transform.x * speed * delta //playerDirection * playerSpeed + 
	if !playerFlip:
		position += dir * speed * delta
	else:
		position += -dir * speed * delta
	
	if position.distance_to(spawnPoint) > maxDist:
		queue_free()	

func _on_bulletShotGun_area_entered(area):
	if area.is_in_group("enemy"):
			area.damage(5, position)
	if !area.is_in_group("bullet") and !area.is_in_group("Player"):
		queue_free()

func _on_bulletShotGun_body_entered(body):
	if !body.is_in_group("bullet") and !body.is_in_group("Player"):
		queue_free()
	
