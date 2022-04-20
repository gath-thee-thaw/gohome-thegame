extends Position2D

onready var player_node = Global.player
onready var camera_node = get_parent()
var offsetting = false

func _ready():
	pass

func _process(delta):
	#print(position.x)
	global_position.x = player_node.global_position.x
	pass

func shooting():
	var current_xpos = position.x
	print(current_xpos)
	offsetting = true
	#var current_xpos = global_position.x
#	if $Tween.is_active() == false:
#		$Tween.interpolate_property(self, "position",
#			Vector2(0,0), Vector2(100,0), 1,
#			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#		$Tween.start()
		#offsetting
	if current_xpos > 0:
		position.x = current_xpos + 100
	elif current_xpos <= 0:
		position.x = current_xpos - 100
	#offsetting = false
