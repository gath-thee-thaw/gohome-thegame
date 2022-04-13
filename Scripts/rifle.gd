extends Node2D


var bullet = load("res://scenes/bullet.tscn")
var mobile = false

var timer
var shootDelay = 5
var canShootB = true

func _ready():
	pass
#	timer = Timer.new()
#	timer.one_shot = true
#	timer.wait_time = shootDelay
#	timer.connect("timeout", self, "on_timeout_complete")
	
	

func _process(delta):
	if(!mobile):
#		look_at(get_global_mouse_position())
		if Input.is_action_pressed("shoot"):
			Shoot()
		
#
	



func Shoot():
		var bul = bullet.instance()
		bul.position = $spawnPoint.global_position
		get_tree().root.add_child(bul)
		bul.playerFlip = get_parent().flip

		
		#timer.start()
		
	   
		
		
		
		
		
	   
		
	
	
	
