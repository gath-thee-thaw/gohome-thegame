extends Area2D

var playerFlip
var speed = 200
var recoil = .5
var dir

func _ready():
	$AnimatedSprite.play("default")
	var val = rand_range(-recoil, recoil)
	dir = Vector2(position.x + 10, position.y + val) - position

func _process(delta):
	#position += playerDirection * playerSpeed + transform.x * speed * delta //playerDirection * playerSpeed + 
	
	if !playerFlip:
		position += dir * speed * delta
	else:
		position += -dir * speed * delta

func _on_bullet2_body_entered(body):
	queue_free()	
	
func _on_bullet2_area_entered(area):
	if area.is_in_group("enemy"):
			area.queue_free()
	queue_free()
