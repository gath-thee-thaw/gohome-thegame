extends Area2D

var playerFlip
export var speed = 1500
export (float, 0, 0.1) var recoil = 0.08
var dir
var pos

var curent_pos
var old_pos

var impact_particles = load("res://scenes/Bullets/BulletImpactParticles.tscn")

func _ready():
	$AnimatedSprite.play("default")
	var val = rand_range(-recoil, recoil)
	dir = Vector2(position.x + 1, position.y - val) - position
	old_pos = global_position

func _process(delta):
	#position += playerDirection * playerSpeed + transform.x * speed * delta //playerDirection * playerSpeed + 
	
	if !playerFlip:
		position += dir * speed * delta
	else:
		position += -dir * speed * delta
		
	
	curent_pos = global_position
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(curent_pos, old_pos, [], 2147483647, true, true)
	
	
	if result.size() != 0:
		if result.collider.is_in_group("enemy"):
		   Global.frame_freeze(0.05, 0.4)
		   result.collider.damage(1, position)
		if result.collider != self:
			destroy()

	old_pos = curent_pos

func _on_Timer_timeout():
	destroy()

func destroy():
	var ip = impact_particles.instance()
	get_parent().add_child(ip)
	ip.global_position = global_position
	ip.emitting = true
	queue_free()
