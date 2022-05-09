extends Area2D


var enemychase = load("res://Scenes/Enemies/EnemyChase.tscn")
var enemyGun = load("res://Scenes/Enemies/EnemyGun.tscn")
var maxteleportRadius = 500
var minteleportRadius = -500




func _on_SpawnTimer_timeout():
	_spawn_enemies()
	
	
	

func _spawn_enemies():
	for n in $SpawnPoints.get_child_count():
		var enemy = enemychase.instance()
		enemy.position = $SpawnPoints.get_child(n).global_position
		get_parent().add_child(enemy)


func _on_TeleportTimer_timeout():
	return
	var xRand = rand_range(minteleportRadius, maxteleportRadius)
	var yRand = rand_range(minteleportRadius, maxteleportRadius)
	global_position = global_position + Vector2(xRand, yRand)
