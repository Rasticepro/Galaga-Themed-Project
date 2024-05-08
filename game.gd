extends Node2D
var sfx_power_up_num = 1
@onready var ENEMY2 = preload("res://enemy_2.tscn")
@onready var ENEMY1 = preload("res://enemy.tscn")
var enemy_spawn = Vector2(840,randi_range(-38, 350))
func _ready():
	reset_vars()
	get_data()
	#Enemy Spawner
	%enemy_spawner.set_wait_time(Global.Enemy_spawn_rate)
	%enemy_spawner.start()
	%Time_Elapsed.set_text("Game Time: " + str(Global.Game_time))
	%Highscore_Counter.set_text("Highscore: " + str(Global.Highscore))
	

func _on_enemy_spawner_timeout():
	if Global.Game_time >= 30:
		if Global.Game_time >= 60:
			spawn_enemy(2)	
		else:
			spawn_enemy(randi_range(1,2))
	else:
		spawn_enemy(1)
	

func _on_game_time_timeout():
	Global.Game_time += 1
	%Time_Elapsed.set_text("Game Time: " + str(Global.Game_time))
	print(Global.Game_time)

func _physics_process(_delta):
	
	if Global.Player_death_sound == true:
		Global.Player_death_sound = false
		$sfx_player_died.play()
	
	if Global.Enemy_died:
		$sfx_enemy_died.play()
		Global.Enemy_died = false
	
	if Global.Player_isdead:
		save_data()
		%cr_died.show()
		%label_died.show()
		%bttn_quit.show()
		%bttn_restart.show()
		
	if Global.Highscore < Global.Points:
		Global.Highscore = Global.Points
		%Highscore_Counter.set_text("Highscore: " + str(Global.Points))
		
		
	%label_unspent_points.set_text("Unspent Points: " + str(Global.Player_level_points))
	%Points_Counter.set_text("Points: " + str(Global.Points))
	%bar_current_mag.set_value(Global.Player_mag_bullets)
	%bar_current_mag.set_max(Global.Player_mag_capacity)
	if Global.Points >= Global.Player_level * 5:
		print("Player Level: " + str(Global.Player_level))
		Global.Player_level += 1
		Global.Player_level_points += 1
		lvl_up(1)

func lvl_up(hs):
	if hs == 1:
		%bttn_fire_rate.show()
		%bttn_mag_capacity.show()
		%bttn_reload_speed.show()
		%label_lvl_up.show()
		%label_unspent_points.show()
	elif hs == 2:
		%bttn_fire_rate.hide()
		%bttn_mag_capacity.hide()
		%bttn_reload_speed.hide()
		%label_lvl_up.hide()
		%label_unspent_points.hide()

func _on_bttn_mag_capacity_pressed():
	sfx_power_up()
	Global.Player_mag_capacity += 3
	Global.Player_level_points -= 1
	if Global.Player_level_points <= 0:
		lvl_up(2)


func _on_bttn_fire_rate_pressed():
	sfx_power_up()
	Global.Player_bullet_fire_rate -= 0.04
	Global.Player_level_points -= 1
	if Global.Player_level_points <= 0:
		lvl_up(2)


func _on_bttn_reload_speed_pressed():
	sfx_power_up()
	Global.Player_bullet_reload_time -= 0.2
	Global.Player_level_points -= 1
	if Global.Player_level_points <= 0:
		lvl_up(2)

#function for spawning enemy. (T = type of enemy)
func spawn_enemy(t):
	enemy_spawn = Vector2(970,randi_range(-37, 350))
	if t == 1:
		var enemy = ENEMY1.instantiate()
		enemy.global_position = enemy_spawn
		%enemy_layer.add_child(enemy)
	if t == 2:
		var enemy = ENEMY2.instantiate()
		enemy.global_position = enemy_spawn
		%enemy_layer.add_child(enemy)

#on quit button pressed quit the game
func _on_bttn_quit_pressed():
	get_tree().quit()

func _on_bttn_restart_pressed():
	get_tree().reload_current_scene()



func reset_vars():
	#reset Player Variables for game start
	Global.Player_movespeed = Global.const_Player_movespeed
	Global.Player_health = Global.const_Player_health
	Global.Player_health_max = Global.const_Player_health_max
	Global.Player_bullet_movespeed = Global.const_Player_bullet_movespeed
	Global.Player_bullet_health = Global.const_Player_bullet_health
	Global.Player_mag_bullets = Global.const_Player_mag_bullets
	Global.Player_mag_capacity = Global.const_Player_mag_capacity
	Global.Player_bullet_reload_time = Global.const_Player_bullet_reload_time
	Global.Player_bullet_fire_rate = Global.const_Player_bullet_fire_rate
	Global.Player_level = Global.const_Player_level
	Global.Player_level_points = Global.const_Player_level_points
	Global.Player_isdead = Global.const_Player_isdead
	
	#reset Enemy Variables for game start
	Global.Enemy_movespeed = Global.const_Enemy_movespeed
	Global.Enemy_spawn_rate = Global.const_Enemy_spawn_rate
	Global.Enemy_health_max = Global.const_Enemy_health_max
	Global.Enemy_bullet_movespeed = Global.const_Enemy_bullet_movespeed
	Global.Enemy_bullet_mags = Global.const_Enemy_bullet_mags
	Global.Enemy_bullet_mags_max = Global.const_Enemy_bullet_mags_max
	Global.Enemy_bullet_reload_time = Global.const_Enemy_bullet_reload_time
	
	#Reset Game Variables
	Global.Game_time = Global.const_Game_time
	Global.Points = Global.const_Points


func save_data():
	
	var file = FileAccess.open("res://galaga.data", FileAccess.WRITE)
	file.store_float(Global.Highscore)


func get_data():
	if FileAccess.file_exists("res://galaga.data"):
		var file = FileAccess.open("res://galaga.data", FileAccess.WRITE_READ)
		Global.Highscore = file.get_float()
func sfx_power_up():
	if sfx_power_up_num == 1:
		$sfx_powerup1.play()
	elif sfx_power_up_num == 2:
		$sfx_powerup2.play()
	elif sfx_power_up_num == 3:
		$sfx_powerup3.play()
	sfx_power_up_num += 1
	
