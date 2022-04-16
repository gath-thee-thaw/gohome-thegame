extends Area2D

export var speed := 500

var _sprites := {Vector2.RIGHT: 1, Vector2.LEFT: 2, Vector2.UP: 3, Vector2.DOWN: 4}
var _velocity := Vector2.ZERO
var flip
var direction

var mobile = false

var time = 0

var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta: float):
	time +=delta
	
	#Get inputs
	if(!mobile):
		direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
		)
	else:
		direction = $CanvasLayer/joyStick.getVelo()
   
	#flip
	if(Input.get_action_strength("right") or direction.x > 0):
		if(flip):
			Global.camera.add_trauma(0.2)
			apply_scale(Vector2(-1,1))
			flip = false
	if(Input.get_action_strength("left")  or direction.x < 0):
		if(!flip):
			Global.camera.add_trauma(0.2)
			apply_scale(Vector2(-1,1))
			flip = true

	 
	#Animation
	if direction.length() != 0:
		$AnimationPlayer.play("Run")
	else:
		$AnimationPlayer.play("RESET")
	
	#move
	if direction.length() > 1.0:
		direction = direction.normalized()
	position += direction * delta * speed
	position.x = clamp(position.x, 60, screen_size.x-60)
	position.y = clamp(position.y, 0, screen_size.y-60)
	
func shoot():
	print("dsafhasdfhkgasdgkj")


