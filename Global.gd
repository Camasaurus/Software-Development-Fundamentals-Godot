extends Node

var rapidFire = false
# An option in the game that allows you to spam bullets. It's powerful.
# "Everyone will know you cheated!"

# Allows the use of a save system according to what user plays the game.
var saveFile = "user://save.dat"

var bulletInstanceCount = 0 # Keeps track of how many bullet instances are current
var enemyBulletInstanceCount = 0

var previousScores = []

var scoringInformation = {
	"currentScore": 0,
	"currentPlayer": "User",
	"highScores": [0,0,0,0,0],
	"highScorePlayersName" : "Winner"
}
# Above is the information necessary to save the highest scores and current scores.


