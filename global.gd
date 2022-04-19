extends Node

var isMobile = false
var shadow = load("res://scenes/Shadow.tscn")
var blood_splash = load("res://scenes/Blood/blood_splash.tscn")
var camera
var player
var enemies = 225
var enemyHud
var mobile = false

func _ready():
	
	if get_tree().current_scene.name != "Main_menu":
		camera = Utils.get_main_node().get_node("Camera2D")
		player = Utils.get_main_node().get_node("YSort").get_node("Player")
		enemyHud = Utils.get_main_node().get_node("Hud").get_node("enemies")
		set_enemyNumber()
		
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
	
func set_enemyNumber():
	enemyHud.text = str(enemies)
