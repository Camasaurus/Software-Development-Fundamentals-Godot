extends RayCast2D

func _ready():
	set_process(true)

func _process(delta):
	if self.is_colliding():
		get_parent().canShoot = false
	else:
		get_parent().canShoot = true
