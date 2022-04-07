extends Control

func _ready():
	for button in $"Layout/Menu Buttons/Buttons VBOX/Scene Buttons".get_children():
	# technically ryan calls it 'game scenes' but its essentially to hold all the game buttons.
		button.connect("pressed", self, "_on_Button_Pressed", [button.scene_to_load])
	$"Layout/Menu Buttons/Buttons VBOX/Scene Buttons/StartGameButton".grab_focus()
		
func _on_Button_Pressed(scene_to_load):
	print(scene_to_load)
	get_tree().change_scene(scene_to_load)