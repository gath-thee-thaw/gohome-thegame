extends Area2D

func _on_Area2D_area_entered(area):
	if(area.is_in_group("Player")):
		print("res://Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
		get_tree().change_scene("res://Levels/level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
		Global.player.shoot()
