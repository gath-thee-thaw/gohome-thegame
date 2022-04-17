extends Node2D


func _ready():
	$AnimationPlayer.play("splash")

func destroy():
	queue_free()
