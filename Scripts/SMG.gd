extends Node2D


var bullet = load("res://scenes/bullet2.tscn")
var shootDelay = .1
var timer = 0
	



func _process(delta):
	
	if Input.is_action_pressed("shoot"):
		if timer <= 0:
			Shoot()
			timer = shootDelay
		
	if timer > 0:
		timer -= delta
#
	



func Shoot():
		var bul = bullet.instance()
		bul.position = $SpawnPoint.global_position
		get_tree().root.add_child(bul)
		bul.playerFlip = get_parent().flip
