extends Node2D

var bullet = load("res://scenes/Bullets/bulletShotGun.tscn")
var shootDelay = .6
var timer = 0
var backStep = 1000
var backStepPos

onready var playerNode = Global.player

func _process(delta):
	if !Input.is_action_pressed("shoot"):
		$AnimationPlayer.play("RESET")
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
	shotgun_knockback()
	
	var bul = bullet.instance()
	bul.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul)
	bul.playerFlip = playerNode.flip
	bul.dir =  bullet(-.05, .05, bul.global_position)
	
	

	var bul2 = bullet.instance()
	bul2.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul2)
	bul2.playerFlip = playerNode.flip
	bul2.dir = bullet(-.05, -.1, bul2.global_position)
	
	

	var bul3 = bullet.instance()
	bul3.position = $SpawnPoint.global_position
	get_tree().root.add_child(bul3)
	bul3.playerFlip = playerNode.flip
	bul3.dir = bullet(.05, .1, bul3.global_position)
	
	
	
	
func shotgun_knockback():
	$AnimationPlayer.play("ShotgunShoot")
	pass

func camera_shake():
	Global.camera.add_trauma(0.35)
	
func bullet(var recoil1, var recoil2, var pos):
	var val = rand_range(recoil1, recoil2)
	var dir = Vector2(pos.x + 1, pos.y - val) - pos
	return dir
