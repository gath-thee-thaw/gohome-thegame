extends KinematicBody2D


export var speed := 500

var _sprites := {Vector2.RIGHT: 1, Vector2.LEFT: 2, Vector2.UP: 3, Vector2.DOWN: 4}
var _velocity := Vector2.ZERO
var flip
var direction

var bullet = load("res://scenes/bullet.tscn")
var mobile = true

func _physics_process(_delta: float) -> void:
	
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
			apply_scale(Vector2(-1,1))
			flip = false
	if(Input.get_action_strength("left")  or direction.x < 0):
		if(!flip):
			apply_scale(Vector2(-1,1))
			flip = true
	
	
	#move
	if direction.length() > 1.0:
		direction = direction.normalized()
	move_and_slide(speed * direction)
	
	
#	
	


