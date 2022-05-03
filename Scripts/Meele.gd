extends Node2D


var damageRange = 200

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		$AnimationPlayer.play("Meele")


func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		area.damage(5, area.position)

func reset():
	$AnimationPlayer.play("RESET")




