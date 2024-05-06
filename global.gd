extends Node

#Player Variables
var Player_movespeed
var Player_health
var Player_health_max
var Player_bullet_movespeed
var Player_bullet_health
var Player_mag_bullets
var Player_mag_capacity
var Player_bullet_reload_time
var Player_bullet_fire_rate
var Player_level
var Player_level_points
var Player_isdead

#Player Reset Variables
const const_Player_movespeed = 400
const const_Player_health = 3
const const_Player_health_max = 3
const const_Player_bullet_movespeed = 300
const const_Player_bullet_health = 5
const const_Player_mag_bullets = 5
const const_Player_mag_capacity = 5
const const_Player_bullet_reload_time = 2
const const_Player_bullet_fire_rate = .25
const const_Player_level = 1
const const_Player_level_points = 1
const const_Player_isdead = false

#Enemy Reset Variables
const const_Enemy_movespeed = 200
const const_Enemy_spawn_rate = 3
const const_Enemy_health_max = 2
const const_Enemy_bullet_movespeed = 300
const const_Enemy_bullet_mags = 2
const const_Enemy_bullet_mags_max = 2
const const_Enemy_bullet_reload_time = 2

#Game Reset Variables
const const_Game_time = 0
const const_Points = 1

#Enemy Variables
var Enemy_movespeed
var Enemy_spawn_rate
var Enemy_health_max
var Enemy_bullet_movespeed
var Enemy_bullet_mags
var Enemy_bullet_mags_max
var Enemy_bullet_reload_time

#Game Variables
var Game_time
var Points
var Highscore = 0
var Data
