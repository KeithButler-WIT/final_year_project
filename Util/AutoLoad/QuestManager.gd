extends Node

var Quests: Dictionary = {
	"MQ001": {
		"Name": "First Meeting",
		"Stage": 1,
		"Description": {
			"1":"Talk to Stranger.",
			"2":"Visit the village.",
			"3":"Check out the shop.",
		}
	},
	"MQ002": {
		"Name": "Leap of Faith",
		"Stage": 1,
		"Description": {
			"1":"Enter the first level.",
		}
	},
	"MQ003": {
		"Name": "First Dive Complete",
		"Stage": 1,
		"Description": {
			"1":"Beat the first level",
		}
	},
	#TODO: Could all be one quest just different stages
	# Example
	#"MQ003": {
		#"Name": "Beat The Game",
		#"Stage": 1,
		#"Description": {
			#"01":"Beat the first level",
			#"02":"Beat the Second level",
			#"03":"Beat the Third level",
			#"04":"Beat the Forth level",
			#"05":"Beat the Fifth level",
		#}
	#},
	"MQ004": {
		"Name": "Second Level Complete",
		"Stage": 1,
		"Description": {
			"1":"Beat the Second level",
		}
	},
	"MQ005": {
		"Name": "Third Level Complete",
		"Stage": 1,
		"Description": {
			"1":"Beat the Third level",
		}
	},
	"MQ006": {
		"Name": "Fourth Level Complete",
		"Stage": 1,
		"Description": {
			"1":"Beat the Fourth level",
		}
	},
}

var ActiveQuests: Dictionary = {}
var CompletedQuests: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#TODO: Decides quests and how their added
	addQuest("MQ001")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func addQuest(questID: String):
	if questID in Quests.keys():
		ActiveQuests[questID] = Quests[questID]

func advanceQuest(questID: String):
	ActiveQuests[questID]["Stage"] += 1;
	var currentStage: String = str(ActiveQuests[questID]["Stage"])
	if currentStage in ActiveQuests[questID]["Description"].keys():
		print(ActiveQuests[questID]["Description"][currentStage])
	else:
		completeQuest(questID)

func completeQuest(questID: String):
	CompletedQuests.append(Quests[questID]["Name"])
	ActiveQuests.erase(questID)
	print("Quest Completed", CompletedQuests)
