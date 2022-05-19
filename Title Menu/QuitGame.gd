extends Button

func _ready():
	pass # Does nothing right now, and is filler.

# This allows the user to (when the quit game button is pressed) close the game entirely.
func _on_QuitGame_pressed():
	get_tree().quit()

