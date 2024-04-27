extends Node

#Player Variables
var Player_movespeed = 400
var Player_health = 3
var Player_health_max = 3
var Player_bullet_movespeed = 300
var Player_bullet_health = 5
var Player_mag_bullets = 5
var Player_mag_capacity = 5
var Player_bullet_reload_time = 2
var Player_bullet_fire_rate = .25
var Player_level = 1
var Player_level_points = 1

#Enemy Variables
var Enemy_movespeed = 200
var Enemy_spawn_rate = 3
var Enemy_health_max = 2
var Enemy_bullet_movespeed = 300
var Enemy_bullet_mags = 2
var Enemy_bullet_mags_max = 2
var Enemy_bullet_reload_time = 2

#Game Variables
var Game_time = 0
var Points = 0

#WIP you lost screen for future David
func player_died():
	print("you died")
