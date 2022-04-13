extends KinematicBody2D

# Movement speed in pixels per second.
export var speed := 500

# We map a direction to a frame index of our AnimatedSprite node's sprite frames.
# See how we use it below to update the character's look direction in the game.
var _sprites := {Vector2.RIGHT: 1, Vector2.LEFT: 2, Vector2.UP: 3, Vector2.DOWN: 4}
var _velocity := Vector2.ZERO
var flip
var direction

var bullet = load("res://scenes/bullet.tscn")


func _physics_process(_delta: float) -> void:
	# Once again, we call `Input.get_action_strength()` to support analog movement.
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if(Input.get_action_strength("right")):
		if(flip):
			apply_scale(Vector2(-1,1))
			flip = false
	if(Input.get_action_strength("left")):
		if(!flip):
			apply_scale(Vector2(-1,1))
			flip = true
	
	$rifle.look_at(get_global_mouse_position())
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	move_and_slide(speed * direction)
	
	if Input.is_action_just_pressed("shoot"):
		Shoot()


func Shoot():
	
	var bul = bullet.instance()
	bul.position = $rifle/spawnPoint.global_position
	bul.rotation_degrees = $rifle.rotation_degrees
	bul.playerDirection = direction
	bul.playerSpeed = speed
	get_tree().root.add_child(bul)
	


