extends CharacterBody2D

#func _ready():
	#$sfx_shoot.play()

func _physics_process(_delta):
	velocity = Vector2(-1,0) * Global.Enemy_bullet_movespeed 
	move_and_slide()


func hit():
	queue_free()
	Global.Points +=.5

func _on_area_2d_body_entered(_body):
	queue_free()
