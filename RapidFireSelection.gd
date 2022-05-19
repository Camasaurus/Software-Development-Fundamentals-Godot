extends CheckButton

func _ready():
	pass

	# Will record whether the button is on or off.
func _on_RapidFireSelection_toggled(button_pressed):
	GlobalVariables.rapidFire = button_pressed
