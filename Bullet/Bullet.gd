extends KinematicBody2D

var speed = 500
# Speed of the player's bullets.

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	var collidedObject = move_and_collide(Vector2(0, -speed*delta))
	# 0, -speed*delta means the bullets go up in the game.
	if (collidedObject):
		if "Enemy" in collidedObject.collider.name:
			collidedObject.get_collider().queue_free()
			GlobalVariables.scoringInformation["currentScore"] +=10
		queue_free()
		# This allows the enemies to give the player +10 score when killed.
