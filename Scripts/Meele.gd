extends Node2D

var cooldown = 0.5

var damageRange = 200
var holding = false

var ready_for_m2 = false
var isTimerOn = false


func _process(delta):
	if Global.canMeele == false:
		visible = false
		if !isTimerOn:
			$Timer2.start()
			isTimerOn = true
		return
	#if Input.is_action_just_pressed("shoot"):
		
#		$AnimationPlayer.play("Meele1")
#		pass
	if Input.is_action_pressed("meele") && ready_for_m2 == false:
		Global.canShoot = false
		visible = true
		
		$AnimatedSprite.set_frame(1)
		holding = true
	elif Input.is_action_just_released("meele"):
		holding = false
		if ready_for_m2 && $AnimationPlayer.is_playing() == false:
			$AnimationPlayer.play("Meele2")
			$Meele2Sound.play()
		elif $AnimationPlayer.is_playing() == false:
			$AnimationPlayer.play("Meele1")
			$Meele1Sound.play()
		
func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		area.damage(5, area.position)
		$Meele1Sound.stop()
		$Meele2Sound.stop()
		$HitSound.play()

func reset():
	$AnimationPlayer.play("RESET")


func _on_Timer_timeout():
	ready_for_m2 = false
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Meele1":
		ready_for_m2 = true
		$Timer.start(cooldown)
	if anim_name == "Meele2":
		ready_for_m2 = false


func _on_Timer2_timeout():
	Global.canMeele = true
	isTimerOn = false
