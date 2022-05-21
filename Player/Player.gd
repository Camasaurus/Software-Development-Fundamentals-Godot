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
		# (21.05.22) I have reorganised the WinScene name to MainGame 6 so it actually works.
		print(str(get_tree().current_scene.name))
		get_tree().change_scene("res://MainGame/MainGame_" + str((int(get_tree().current_scene.filename) + 1)) + ".tscn")
		# (18.05.22) At the moment the change scene above (taken from a youtube vid i found https://youtu.be/c2mkyW_TymY)
		# Above is trying to bring the user to level number 2 but the number at the moment is not changing from 1.
		# filename directly looks into the scene name such as level "1" and level "2"

		# When the player goes into the left boundary, the player is sent OUTSIDE of the boundary, unable to pass through.
		# When the player goes into the right boundary, the player is send OUTSIDE of the boundary, unable to pass through.
func _colliding(area):
	if area.is_in_group("left"):
		position.x=80
	if area.is_in_group("right"):
		position.x=1210

func _not_colliding():
	pass
	# When the player is not in a boundary, you don't need to worry about it.

# Below is a collection of health mechanics taken from "Game Endeavour" 
#(https://www.youtube.com/watch?v=Cx_i4Uei_ME)
export (float) var max_health = 100

onready var health = max_health setget _set_health
onready var invulnerability_timer = $InvulnerabilityTimer
onready var effects_animation = $EffectsAnimation

signal health_updated(health)
signal killed()

func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		if health == 0:
			kill()
			emit_signal("killed")

func kill():
	get_tree().change_scene("res://EndScene.tscn")

func damage(amount):
	if invulnerability_timer.is_stopped():
		invulnerability_timer.start()
		_set_health(health - amount)
		effects_animation.play("damage")
		effects_animation.queue("flash")
	
func _on_InvulnerabilityTimer_timeout():
	effects_animation.stop()
