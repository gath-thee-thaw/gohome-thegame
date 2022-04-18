extends Area2D

var playerFlip
var speed = 1500
var direction
var maxDist = 400
var spawnPoint

func _ready():
	$AnimatedSprite.play("default")
func _process(delta):
	#position += playerDirection * playerSpeed + transform.x * speed * delta //playerDirection * playerSpeed + 
	if !playerFlip:
		position += -direction * speed * delta
	else:
		position += direction * speed * delta
	
	if position.distance_to(spawnPoint) > maxDist:
		queue_free()	

func _on_bulletShotGun_area_entered(area):
	if area.is_in_group("enemy"):
			area.damage(5)
	if !area.is_in_group("bullet") and !area.is_in_group("Player"):
		queue_free()

func _on_bulletShotGun_body_entered(body):
	if !body.is_in_group("bullet") and !body.is_in_group("Player"):
		queue_free()
	
