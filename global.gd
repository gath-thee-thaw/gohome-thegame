extends Node

var isMobile = true
var shadow = load("res://scenes/Shadow.tscn")
var blood_splash = load("res://scenes/Blood/blood_splash.tscn")
onready var camera = Utils.get_main_node().get_node("Camera2D")
onready var player = Utils.get_main_node().get_node("YSort").get_node("Player")

func _ready():
	#add shadows
	player.add_child(shadow.instance())
	var enemies = get_tree().get_nodes_in_group("enemy")
	for i in enemies:
		var shdw = shadow.instance()
		i.add_child(shdw)

func frame_freeze(timeScale, duration):
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0
