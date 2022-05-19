extends KinematicBody2D

var bullet = preload("res://Bullet-Enemy/Bullet-Enemy.tscn")

# When enemies collide with either the right or left boundaries, they will start moving in the opposite direction.
# When this happens, this will re-enact the 'Space Invaders' left to right movement pattern of enemies.
# When enemies collide with borders, they also move down in the game, closer to the player.
func _colliding(area):
	if area.is_in_group("right"):
		get_parent().global_position.y += 10
		get_parent().speed = get_parent().speed * -1
	if area.is_in_group("left"):
		get_parent().global_position.y += 10
		get_parent().speed = get_parent().speed * -1

# This number generator
func _process(delta):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(2.0,30.0)
	yield(get_tree().create_timer(my_random_number), "timeout")
	#$Timer.start(my_random_number); yield($Timer, "timeout")
	# ^ the problem here is that the random timer allows differentiating enemies shoot bullets.
	if GlobalVariables.enemyBulletInstanceCount < 5:
		var bulletInstance = bullet.instance()
		
		bulletInstance.position = Vector2(global_position.x, global_position.y)
		get_tree().get_root().add_child(bulletInstance)

func _ready():
	$Area2D.connect("area_entered", self, "_colliding")
