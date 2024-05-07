extends CharacterBody2D
var enemy_dir = Vector2()
var enemy_movepattern = "CHARGE"
var enemy_wander_dir = randi_range(-1,1)
var enemy_health = Global.Enemy_health_max
var enemy_can_shoot = false
var BULLET = preload("res://enemy_bullet.tscn")
var enemy_bullet_mags = Global.Enemy_bullet_mags

func _ready():
	%enemy_hp.value = Global.Enemy_health_max 
	%enemy_hp.max_value = Global.Enemy_health_max
	
func shoot():
	if enemy_can_shoot and enemy_bullet_mags > 0:
		enemy_bullet_mags -= 1
		enemy_can_shoot = false
		%enemy_fire_rate.set_wait_time(Global.Enemy_bullet_reload_time)
		%enemy_fire_rate.start()
		var enemy_bullet = BULLET.instantiate()
		enemy_bullet.global_position = %enemy_bullet_marker.global_position
		get_parent().add_child(enemy_bullet)
		

#when enemy wait timer stops, set move pattern to charge
func _on_patience_timeout():
	enemy_movepattern = "CHARGE"
	#enemy_dir = Vector2(-1,0)

#check enemy move pattern
func _physics_process(_delta):
	
	#if move pattern is wander move in a random direction at random speeds.
	if enemy_movepattern == "WANDER":	
		enemy_dir = Vector2(0,enemy_wander_dir)
		var random = randi_range(0,10) * 0.3
		velocity = enemy_dir * Global.Enemy_movespeed * random
		move_and_slide()
	
	#if move pattern is charge start moving towards the player side of screen.
	if enemy_movepattern == "CHARGE":
		enemy_dir = Vector2(-1,0)
		velocity = enemy_dir * Global.Enemy_movespeed
		move_and_slide()
	
	#run the shoot function
	shoot()

#when the Timer dir times out, if movepattern is set to wander then change direction randomly 
func _on_dir_timeout():
	if enemy_movepattern == "WANDER":
		enemy_wander_dir = randi_range(-1,1)


#called when player bullets hit enemies
func hit():
	enemy_health -=1
	%enemy_hp.value = enemy_health
	%enemy_hp.max_value = Global.Enemy_health_max
	
	#check if the enemy health bar is visible
	if !%enemy_hp.is_visible() and enemy_health < Global.Enemy_health_max:
		%enemy_hp.show()
		print("progrss bar shown")
	
	#if enemy health is lower than or equal to 0 then remove enemy from game
	if enemy_health <= 0:
		Global.Enemy_died = true
		Global.Points +=1
		
		queue_free()
	elif enemy_health > 0:
		$sfx_hit.play()



#when Timer enemy_fire_rate times out, run shoot function
func _on_enemy_fire_rate_timeout():
	enemy_can_shoot = true
	shoot()


func _on_move_on_spawn_timeout():
	enemy_movepattern = "WANDER"
	%dir.start()
	enemy_can_shoot = true
