extends Button

func _ready():
	pass # Replace with function body.

func _on_WinButton_pressed():
	GlobalVariables.scoringInformation["currentScore"] = 0
	get_tree().change_scene("res://MainGame/MainGame_1.tscn")
