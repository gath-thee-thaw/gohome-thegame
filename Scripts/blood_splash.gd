extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	play_random_animation()
	rotation_degrees = rand_range(-40,40)
	#meka hadapanko random z index ekak enna
	z_index = 0
	play_random_sound()
func destroy():
	queue_free()

func play_random_animation():
	var animations = $AnimatedSprite.frames.get_animation_names()
	var animation_id = randi() % animations.size()
	var animation_name = animations[animation_id]
	$AnimatedSprite.play(animation_name)

func play_random_sound():
	$RandomAudioStreamPlayer2D.play()
	pass
