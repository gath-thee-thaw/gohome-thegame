extends Area2D

export var speed := 500

var _sprites := {Vector2.RIGHT: 1, Vector2.LEFT: 2, Vector2.UP: 3, Vector2.DOWN: 4}
var _velocity := Vector2.ZERO
var flip
var direction

var time = 0
var screen_size

export var knockback = 50
var isknockback = false
var current_xpos


func _ready():
	screen_size = Vector2(3000,720)


func _physics_process(delta: float):
	time +=delta
	#Get inputs
	if(!Global.mobile):
		direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	else:
		direction = $CanvasLayer/joyStick.getVelo()
   
	#flip
	if(Input.get_action_strength("right") or direction.x > 0):
		if(flip):
			apply_scale(Vector2(-1,1))
			flip = false
	if(Input.get_action_strength("left")  or direction.x < 0):
		if(!flip):
			apply_scale(Vector2(-1,1))
			flip = true
			

	#Animation
	if direction.length() != 0:
		$AnimationPlayer.play("Run")
	elif direction.length() == 0:
		$AnimationPlayer.play("RESET")
	
	#move
	if direction.length() > 1.0:
		direction = direction.normalized()
	position += direction * delta * speed
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if isknockback:
		global_position.x = lerp(global_position.x, current_xpos + knockback, 0.6)
		isknockback = false
		
		
func shoot():
	print("dsafhasdfhkgasdgkj")

func bullet_hit(pos, dir):
	isknockback = true
	current_xpos = global_position.x
	$ImpactAnimationPlayer.stop(true)
	$ImpactAnimationPlayer.play("Hit")
	Global.frame_freeze(0.05, 0.45)
	var bp = Global.blood_splash.instance()
	add_child(bp)
	if dir:
		if flip:
			bp.set_scale(Vector2(-1,1))
			knockback = -(abs(knockback))
			
		else:
			bp.set_scale(Vector2(1,1))
			knockback = -(abs(knockback))
			
	if !dir:
		if flip:
			bp.set_scale(Vector2(1,1))
			knockback = abs(knockback)
			print("lol")
		else:
			bp.set_scale(Vector2(-1,1))
			knockback = abs(knockback)
	bp.global_position = pos
