# This script runs for each enemy bullet that is spawned.
# This allows the enemy bullet to collide with the player.
# This also determines the speed of the bullets.

extends KinematicBody2D

var speed = 500


func _ready():
	GlobalVariables.enemyBulletInstanceCount += 1
	print("bullet #: ", GlobalVariables.enemyBulletInstanceCount)
	set_physics_process(true)
	yield(get_tree().create_timer(3.0), "timeout")
	GlobalVariables.enemyBulletInstanceCount -= 1
	queue_free()

func _physics_process(delta):
	var collidedObject = move_and_collide(Vector2(0, +speed*delta*0.4))
	# When the bullet detects something it collides with.
	if (collidedObject):
		#Note: print("Enemy collide: ",collidedObject.collider.name)
		if "Enemy" in collidedObject.collider.name:
			pass
			#collidedObject.get_collider().queue_free() #Don't kill the enemies.
		else:
			# Removes the bullets
			queue_free()
			GlobalVariables.enemyBulletInstanceCount -= 1
			print("Enemy Bullets: ", GlobalVariables.enemyBulletInstanceCount)
