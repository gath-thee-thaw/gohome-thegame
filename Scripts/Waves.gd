extends Sprite

export (float, 0, 1000) var x_frequency = 0.2
export (float, 0, 1000) var y_frequency = 0.2

export (float, 1000) var x_amplitude = 10
export (float, 1000) var y_amplitude = 10
var time = 0

func _physics_process(delta):
	time += delta
	var ymovement = cos(time*y_frequency)*y_amplitude
	position.y+=ymovement * delta

	var xmovement = cos(time*x_frequency)*x_amplitude
	position.x+=xmovement * delta
