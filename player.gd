extends CharacterBody2D
var movespeed = 200
var Player_can_shoot = true
var Player_is_reloading = false
var BULLET = preload("res://player_bullet.tscn")

func _physics_process(_delta):
	var direction = Vector2(0, Input.get_action_strength("down") - Input.get_action_strength("up"))
	velocity = direction * Global.Player_movespeed
	move_and_slide()
	if Input.is_action_pressed("shoot") and Player_can_shoot and Global.Player_mag_bullets > 0 and not Player_is_reloading:
		%fire_rate.set_wait_time(Global.Player_bullet_fire_rate)
		shoot()

func _on_area_2d_body_entered(body):
	body.queue_free()
	Global.Player_health -= 1
	if Global.Player_health <= 0:
		Global.player_died()
		queue_free()

func hit():
	print("player hit")

#called when player presses shoot button
func shoot():
	if Player_can_shoot and Global.Player_mag_bullets > 0 and not Player_is_reloading:
		
		#remove a mag from player and create a bullet
		Global.Player_mag_bullets -= 1
		var bullet = BULLET.instantiate()
		bullet.global_position = %bullet_marker.global_position
		get_parent().add_child(bullet)
		Player_can_shoot = false
		%fire_rate.start()
		
		#if player runs out of mags reload
		if Global.Player_mag_bullets <= 0:
			Player_can_shoot = false
			Player_is_reloading = true
			%reload_time.set_wait_time(Global.Player_bullet_reload_time)
			%reload_time.start()

func _on_reload_time_timeout():
	Player_can_shoot = true
	Player_is_reloading = false
	Global.Player_mag_bullets = Global.Player_mag_capacity


func _on_fire_rate_timeout():
	Player_can_shoot = true
