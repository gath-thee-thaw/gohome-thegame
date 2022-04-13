extends Node2D


var bullet = load("res://scenes/bullet2.tscn")
var mobile = false


	

func _process(delta):
	if(!mobile):
#		look_at(get_global_mouse_position())
		if Input.is_action_just_pressed("shoot"):
			Shoot()
		
#
	



func Shoot():
		var bul = bullet.instance()
		bul.position = $spawnPoint.global_position
		get_tree().root.add_child(bul)
		bul.playerFlip = get_parent().flip

		
		
		
	   
		
		
		
		
		
	   
		
	
	
	
