extends Button

func _ready():
	pass

func _on_WinButton_pressed():
	GlobalVariables.scoringInformation["currentScore"] = 0
	get_tree().change_scene("res://MainGame/MainGame_1.tscn")
	# When you win, you can press the button and be sent back to level 1.
	# Also, when you press the button, your current score will be set back to 0.
