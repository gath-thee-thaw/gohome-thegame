extends Area2D

var playerFlip
var speed = 1000

func _ready():
	$AnimatedSprite.play("default")

func _process(delta):
	#position += playerDirection * playerSpeed + transform.x * speed * delta //playerDirection * playerSpeed + 
	if !playerFlip:
		position += transform.x * speed * delta
	else:
		position += -transform.x * speed * delta


func _on_bulletEnenmy_area_entered(area):
	if area.is_in_group("player"):
		Global.player.bullet_hit(position, playerFlip)
	queue_free()	


func _on_BulletEnemy_body_entered(_body):
	queue_free()
