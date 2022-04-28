extends Position2D

export var cooldown = 0.6
export var shoot_offset = 200
onready var player_node = Global.player
onready var camera_node = get_parent()
var is_offsetting = false
var currentx_pos = Vector2(0,0)

func _ready():
	$Timer.set_wait_time(cooldown)
	global_position.y = 360
	
	
func _process(_delta):

	if player_node.flip:
		shoot_offset = -abs(shoot_offset)

	if !player_node.flip:
		shoot_offset = abs(shoot_offset)

	if is_offsetting:
		global_position.x = lerp(global_position.x , currentx_pos + shoot_offset , 0.2)

	else:
		global_position.x = lerp(global_position.x , player_node.global_position.x , 0.05)


func shooting():
	currentx_pos = player_node.global_position.x
	$Timer.start(cooldown)
	is_offsetting = true


func _on_Timer_timeout():
	is_offsetting = false
