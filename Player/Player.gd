extends KinematicBody2D

var movement_speed = 200
# Speed of the player.
var bulletSource = preload ("res://Bullet/Bullet.tscn")
# In order to load the player's bullets, they are sourced here.

func _ready():
	set_process(true)
	set_physics_process(true)
	$Area2D.connect("area_entered", self, "_colliding")
	$Area2D.connect("area_exited", self, "_not_colliding")
	# Detects if a player collides with a boundary.

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2(-movement_speed * delta, 0))
	if Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2(movement_speed * delta, 0))
	# These inputs allow the player to move left and right in the game, just like space invaders!
	
func _process(delta):
	if GlobalVariables.rapidFire:
		if Input.is_action_pressed("fire"):
			var bulletInstance = bulletSource.instance()
			bulletInstance.position = Vector2(position.x, position.y-40)
			get_tree().get_root().add_child(bulletInstance)
	# This here is only for rapid fire, as it is part of the player's attacking code.
	else:
		if Input.is_action_just_pressed("fire"):
			var bulletInstance = bulletSource.instance()
			bulletInstance.position = Vector2(position.x, position.y-40)
			get_tree().get_root().add_child(bulletInstance)
	# Every time the fire key is pressed (space bar) one bullet will go up in the game, killing any enemy is collides with.
	if get_tree().get_nodes_in_group("enemy").size() == 0:
		# When all enemies are killed, go to next level (ideally)
		# Note for later reference: get_tree().change_scene("res://Win Scene/WinScene.tscn")
		get_tree().change_scene("res://MainGame/MainGame_" + str((int(get_tree().current_scene.name) + 1)) + ".tscn")
		# (18.05.22) At the moment the change scene above (taken from a youtube vid i found https://youtu.be/c2mkyW_TymY)
		# Above is trying to bring the user to level number 2 but the number at the moment is not changing from 1.

func _colliding(area):
	if area.is_in_group("left"):
		#print("left")
		position.x=80
		# When the player goes into the left boundary, the player is sent OUTSIDE of the boundary, unable to pass through.
	if area.is_in_group("right"):
		#print("right")
		position.x=1210
		# When the player goes into the right boundary, the player is send OUTSIDE of the boundary, unable to pass through.

func _not_colliding():
	pass
	# When the player is not in a boundary, you don't need to worry about it.
