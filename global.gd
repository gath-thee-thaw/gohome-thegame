extends Node

var isMobile = true
onready var camera = Utils.get_main_node().get_node("Camera2D")
onready var player = Utils.get_main_node().get_node("YSort").get_node("Player")
