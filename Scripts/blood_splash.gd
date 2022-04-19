extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	$AnimationPlayer.play("splash")
	rotation_degrees = rand_range(-40,40)
	
	#meka hadapanko random z index ekak enna
	z_index = 0

func destroy():
	queue_free()

