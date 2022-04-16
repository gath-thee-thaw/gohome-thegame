extends Node2D

var bullet = load("res://scenes/Bullets/bulletShotGun.tscn")
var shootDelay = .5
var timer = 0
var backStep = 1000
var backStepPos

onready var playerNode

func _process(delta):
	playerNode = Global.player
	
	if Input.is_action_just_pressed("shoot"):
		if timer <= 0:
			Shoot()
			timer = shootDelay
			if !playerNode.flip:
				backStepPos = playerNode.position.x - backStep
				playerNode.position.x = lerp(playerNode.position.x, backStepPos, delta)
			else:
				backStepPos = playerNode.position.x + backStep
				playerNode.position.x = lerp(playerNode.position.x, backStepPos, delta)
		
	if timer > 0:
		timer -= delta

func Shoot():
	$SpawnPoint/CPUParticles2D.set_emitting(true)
	Global.camera.add_trauma(0.35)
	shotgun_knockback()
	var bul = bullet.instance()
	bul.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul)
	bul.playerFlip = playerNode.flip
	bul.direction = ($SpawnPoint/shot1.position - $SpawnPoint.position).normalized()
	bul.spawnPoint = $SpawnPoint.global_position
		
	var bul2 = bullet.instance()
	bul2.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul2)
	bul2.playerFlip = playerNode.flip
	bul2.direction = ($SpawnPoint/shot2.position - $SpawnPoint.position).normalized()
	bul2.spawnPoint = $SpawnPoint.global_position
		
	var bul3 = bullet.instance()
	bul3.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul3)
	bul3.playerFlip = playerNode.flip
	bul3.direction = ($SpawnPoint/shot3.position - $SpawnPoint.position).normalized()
	bul3.spawnPoint = $SpawnPoint.global_position
	
func shotgun_knockback():
	$AnimationPlayer.play("ShotgunShoot")
	pass
