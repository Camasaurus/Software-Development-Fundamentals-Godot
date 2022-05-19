extends Label

func _process(delta):
	self.text = str(GlobalVariables.scoringInformation["currentScore"])
