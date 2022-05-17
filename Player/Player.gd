extends KinematicBody2D

var movement_speed = 200
var bulletSource = preload ("res://Bullet/Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	set_physics_process(true)
	$Area2D.connect("area_entered", self, "_colliding")
	$Area2D.connect("area_exited", self, "_not_colliding")

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2(-movement_speed * delta, 0))
	if Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2(movement_speed * delta, 0))

func _process(delta):
	if GlobalVariables.rapidFire:
		if Input.is_action_pressed("fire"):
			var bulletInstance = bulletSource.instance()
			bulletInstance.position = Vector2(position.x, position.y-40)
			get_tree().get_root().add_child(bulletInstance)
	else:
		if Input.is_action_just_pressed("fire"):
			var bulletInstance = bulletSource.instance()
			bulletInstance.position = Vector2(position.x, position.y-40)
			get_tree().get_root().add_child(bulletInstance)
	if get_tree().get_nodes_in_group("enemy").size() == 0:
		#get_tree().change_scene("res://Win Scene/WinScene.tscn")
		#I accidentally disabled the win scene while making level 2
		pass

func _colliding(area):
	if area.is_in_group("left"):
		position.x=80
		#print("left")
	if area.is_in_group("right"):
		#print("right")
		position.x=1210

func _not_colliding():
	pass
