extends Button

func _ready():
	pass

# When you lose, you can be sent back to level 1 to retry.
# Your score will be reset back to 0 when you click this button.
func _on_Button_pressed():
	GlobalVariables.scoringInformation["currentScore"] = 0
	get_tree().change_scene("res://MainGame/MainGame_1.tscn")
