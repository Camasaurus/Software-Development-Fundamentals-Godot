extends Node2D

func _ready():
	# Below sorts the array
	GlobalVariables.scoringInformation["highScores"].sort()
	
	# Searches the array value, or the position in the array where it will "fit".
	var highScorePosition = GlobalVariables.scoringInformation["highScores"].bsearch(GlobalVariables.scoringInformation["currentScore"], true)
	print("position #", highScorePosition)
	
	# Inserts the value into the array at the correct position.
	GlobalVariables.scoringInformation["highScores"].insert(highScorePosition, GlobalVariables.scoringInformation["currentScore"])
	
	# Removes the first (and lowest) score.
	GlobalVariables.scoringInformation["highScores"].remove(0)
	
	#Debugging. (???)
	print(GlobalVariables.scoringInformation["highScores"])
	saveData()

func saveData():
	var file = File.new()
	var error = file.open(GlobalVariables.saveFile, file.WRITE)
	if error == OK:
		file.store_var(GlobalVariables.scoringInformation)
		file.close()
		print("!!Data Saved!!")
	# If there is an error, your data will be stored, and saved.
	else :
		print("!!Data Not Saved!!")

# TESTING INFO ABOUT TRYING TO GET THE FILE TO DISAPPEAR. IGNORE!!
#func delete_file_with_extension(ext):
	#var dir = Directory.new()
	#dir.open("user://save.dat")
#http://docs.godotengine.org/en/stable/classes/class_directory.html?highlight=delete#class-directory-remove
	#dir.list_dir_begin()
	#while true:
		#var file = dir.get_next()
		#if file == "":
			#break
		#elif not file.begins_with(".") and file.right((file.length()-ext.length())) == ext:
			#dir.remove(file)
	#dir.list_dir_end()
