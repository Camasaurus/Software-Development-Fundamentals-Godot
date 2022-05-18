extends Control

export(int) var countdownMax
var currentTimer

func _ready():
	currentTimer = countdownMax
	$HUD/Countdown.text = str(currentTimer)
	# Shows the countdown ingame.
	
	for button in $"HUD/Buttons VBOX 2".get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
	# All the buttons in Buttons VBOX 2 are equipped with a scene to load into.
	
	set_process(true)
	while currentTimer > 0:
		yield(get_tree().create_timer(1.0), "timeout")
		$HUD/Countdown.text = str(currentTimer)
		# High score from the dictonary in Global.gd needs to be updated somehow, but it's here.
		currentTimer = currentTimer - 1
		print(currentTimer)
	print("Game Over")
	# This block of text creates a timer, always going down every second. Saying "Game Over" when the timer hits zero.
	
	if GlobalVariables.previousScores.size() < 5:
		GlobalVariables.previousScores.push_front(GlobalVariables.scoringInformation["currentScore"])
		# This puts the newest score on the leaderboard (top 5 best scores)
	else: 
		GlobalVariables.previousScores.remove(4)
		# This removes the fourth element of the high scores (0,1st,2nd,3rd,4th) <-
	print(GlobalVariables.previousScores)
	get_tree().change_scene("res://EndScene.tscn")
	# If you do not kill enough enemies (or the timer runs out) you are sent to the You Lose screen.

func _process(_delta):
	$HUD/CurrentScore.text = str(GlobalVariables.scoringInformation["currentScore"])
	# Shows the current score ingame.
	
func _on_Button_pressed(scene_to_load):
	print(scene_to_load)
	get_tree().change_scene(scene_to_load)
	# Uses variable 'Scene to load' in this page.
