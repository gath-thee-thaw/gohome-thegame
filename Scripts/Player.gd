extends KinematicBody2D

# Movement speed in pixels per second.
export var speed := 500

# We map a direction to a frame index of our AnimatedSprite node's sprite frames.
# See how we use it below to update the character's look direction in the game.
var _sprites := {Vector2.RIGHT: 1, Vector2.LEFT: 2, Vector2.UP: 3, Vector2.DOWN: 4}
var _velocity := Vector2.ZERO

onready var animated_sprite: AnimatedSprite = $AnimatedSprite


func _physics_process(_delta: float) -> void:
	# Once again, we call `Input.get_action_strength()` to support analog movement.
	var direction := Vector2(
		# This first line calculates the X direction, the vector's first component.
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		# And here, we calculate the Y direction. Note that the Y-axis points 
		# DOWN in games.
		# That is to say, a Y value of `1.0` points downward.
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	# When aiming the joystick diagonally, the direction vector can have a length 
	# greater than 1.0, making the character move faster than our maximum expected
	# speed. When that happens, we limit the vector's length to ensure the player 
	# can't go beyond the maximum speed.
	if direction.length() > 1.0:
		direction = direction.normalized()
	move_and_slide(speed * direction)




