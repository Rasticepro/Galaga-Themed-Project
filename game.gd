extends Node2D

@onready var ENEMY2 = preload("res://enemy_2.tscn")
@onready var ENEMY1 = preload("res://enemy.tscn")
var enemy_spawn = Vector2(840,randi_range(-38, 350))
func _ready():
	%enemy_spawner.set_wait_time(Global.Enemy_spawn_rate)
	%enemy_spawner.start()
	%Time_Elapsed.set_text("Game Time: " + str(Global.Game_time))

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
	Global.Player_mag_capacity += 1
	Global.Player_level_points -= 1
	if Global.Player_level_points <= 0:
		lvl_up(2)


func _on_bttn_fire_rate_pressed():
	Global.Player_bullet_fire_rate -= 0.02
	Global.Player_level_points -= 1
	if Global.Player_level_points <= 0:
		lvl_up(2)


func _on_bttn_reload_speed_pressed():
	Global.Player_bullet_reload_time -= 0.1
	Global.Player_level_points -= 1
	if Global.Player_level_points <= 0:
		lvl_up(2)

#function for spawning enemy. (T = type of enemy)
#WIP
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
