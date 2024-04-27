extends TextureProgressBar

func _physics_process(_delta):
	max_value = Global.Player_health_max
	value = Global.Player_health
