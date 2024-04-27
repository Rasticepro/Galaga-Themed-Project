extends CharacterBody2D


func _physics_process(_delta):
	velocity = Vector2(1,0) * Global.Player_bullet_movespeed
	move_and_slide()

func hit():
	print("error hit")

func _on_area_2d_body_entered(body):
	Global.Player_bullet_health -= 1
	body.hit()
	if Global.Player_bullet_health <= 0:
		queue_free()
