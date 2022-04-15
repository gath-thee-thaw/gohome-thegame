extends Camera2D

export (float, 1, 1000) var frequency = 1
export (float, 1000) var amplitude = 10
var amplitude_x =0
var amplitude_y =0
var time = 0
var rng = RandomNumberGenerator.new()

export var decay = 1.0  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).
export (NodePath) var target  # Assign the node this camera will follow.

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

func _ready():
	set_position(get_viewport_rect().size/2)

	var timer = Timer.new()
	timer.set_wait_time(frequency)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "update_amplitude")
	add_child(timer)
	timer.start()
	
	randomize()

 
func _physics_process(delta):
	time += delta
	var movement = Vector2(cos(time*frequency)*amplitude_x,sin(time*frequency)*amplitude_y)
	position += movement * delta
	
	if target:
		global_position = get_node(target).global_position
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
func update_amplitude():
	rng.randomize()
	amplitude_x = rng.randf_range(-amplitude, amplitude)
	amplitude_y = rng.randf_range(-amplitude, amplitude)

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
func shake():
	var amount = pow(trauma, trauma_power)
	
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)
