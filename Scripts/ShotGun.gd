extends Node2D

var bullet = load("res://scenes/bulletShotGun.tscn")
var shootDelay = .5
var timer = 0
var backStep = 1000
var backStepPos

func _process(delta):
	
	if Input.is_action_just_pressed("shoot"):
		if timer <= 0:
			Shoot()
			timer = shootDelay
			if !get_parent().flip:
				backStepPos = get_parent().position.x - backStep
				get_parent().position.x = lerp(get_parent().position.x, backStepPos, delta)
			else:
				backStepPos = get_parent().position.x + backStep
				get_parent().position.x = lerp(get_parent().position.x, backStepPos, delta)
		
	if timer > 0:
		timer -= delta

func Shoot():
	Global.camera.add_trauma(0.35)
	get_parent().shotgun_knockback()
	var bul = bullet.instance()
	bul.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul)
	bul.playerFlip = get_parent().flip
	bul.direction = ($SpawnPoint/shot1.position - $SpawnPoint.position).normalized()
	bul.spawnPoint = $SpawnPoint.global_position
		
	var bul2 = bullet.instance()
	bul2.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul2)
	bul2.playerFlip = get_parent().flip
	bul2.direction = ($SpawnPoint/shot2.position - $SpawnPoint.position).normalized()
	bul2.spawnPoint = $SpawnPoint.global_position
		
	var bul3 = bullet.instance()
	bul3.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul3)
	bul3.playerFlip = get_parent().flip
	bul3.direction = ($SpawnPoint/shot3.position - $SpawnPoint.position).normalized()
	bul3.spawnPoint = $SpawnPoint.global_position
