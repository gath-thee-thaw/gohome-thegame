extends Node2D

export var fire_rate = 0.2
var bullet = load("res://scenes/bullet2.tscn")
var can_fire = true

func _process(delta):
	if Input.is_action_pressed("shoot"):
		Shoot()
			

func Shoot():
	if can_fire:
		can_fire = false
		var bul = bullet.instance()
		bul.position = $spawnPoint.global_position
		get_tree().root.add_child(bul)
		bul.playerFlip = get_parent().flip
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

