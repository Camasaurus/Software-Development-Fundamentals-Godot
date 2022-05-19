# This script runs for each enemy bullet that is spawned.
# This allows the enemy bullet to collide with the player.

extends KinematicBody2D

var speed = 500
# This also determines the speed of the bullets.

func _ready():
	GlobalVariables.enemyBulletInstanceCount += 1
	print("bullet #: ", GlobalVariables.enemyBulletInstanceCount)
	set_physics_process(true)
	yield(get_tree().create_timer(3.0), "timeout")
	GlobalVariables.enemyBulletInstanceCount -= 1
	queue_free()

			# Queue_free() allows the bullets to disappear when they come in contact with something.
func _physics_process(delta):
	var collidedObject = move_and_collide(Vector2(0, +speed*delta*0.4))
	# When the bullet detects something it collides with.
	if (collidedObject):
		#Note: print("Enemy collide: ",collidedObject.collider.name)
		if "Enemy" in collidedObject.collider.name:
			pass
			#Don't kill the enemies with their own bullets!.
		elif "Player" in collidedObject.collider.name:
			print("Hit!")
			queue_free()
		else:
			queue_free()
			GlobalVariables.enemyBulletInstanceCount -= 1
			print("Enemy Bullets: ", GlobalVariables.enemyBulletInstanceCount)
			# This puts the bullet count in the output.
