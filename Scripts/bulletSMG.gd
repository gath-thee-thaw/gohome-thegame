extends Area2D

var playerFlip
export var speed = 1500
export (float, 0, 0.1) var recoil = 0.08
var dir

func _ready():
	$AnimatedSprite.play("default")
	var val = rand_range(-recoil, recoil)
	dir = Vector2(position.x + 1, position.y - val) - position

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
		Global.frame_freeze(0.05, 0.4)
		area.damage(1)
	queue_free()
