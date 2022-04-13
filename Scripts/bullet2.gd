extends Area2D



var playerFlip
var speed = 1000



func _process(delta):
	#position += playerDirection * playerSpeed + transform.x * speed * delta //playerDirection * playerSpeed + 
	if !playerFlip:
		position += transform.x * speed * delta
	else:
		position += -transform.x * speed * delta
	
	


func _on_bullet2_body_entered(body):
	queue_free()	
	

func _on_bullet2_area_entered(area):
	if area.is_in_group("enemy"):
			area.queue_free()
	queue_free()	

