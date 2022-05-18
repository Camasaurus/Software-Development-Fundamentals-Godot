extends Control

func _ready():
	for button in $"Layout/Menu Buttons/Buttons VBOX/Scene Buttons".get_children():
	# technically ryan calls it 'game scenes' but its essentially to hold all the game buttons.
		button.connect("pressed", self, "_on_Button_Pressed", [button.scene_to_load])
	$"Layout/Menu Buttons/Buttons VBOX/Scene Buttons/StartGameButton".grab_focus()
	# When you load up the game, you can press the up and down arrows and press space to press the buttons without moving your mouse! Wow!
		
	var file = File.new()
	# Creates a new save file.
	if file.file_exists(GlobalVariables.saveFile):
		var error = file.open(GlobalVariables.saveFile, File.READ)
		# If there is an error, use what the current file's save data is.
		if error == OK:
			var player_data = file.get_var()
			file.close()
			GlobalVariables.scoringInformation = player_data
			GlobalVariables.scoringInformation["currentScore"] = 0
		# If there is an error, reset the player's save data.
		
func _on_Button_Pressed(scene_to_load):
	print(scene_to_load)
	get_tree().change_scene(scene_to_load)
# Uses variable 'Scene to load' in this page.
