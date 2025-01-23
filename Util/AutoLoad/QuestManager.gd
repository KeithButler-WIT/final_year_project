extends Node

var Quests: Dictionary = {
	"MQ001": {
		"Name": "First Meeting",
		"Stage": 1,
		"Description": {
			"01":"Talk to Stranger.",
			"02":"Visit the village.",
			"03":"Check out the shop.",
		}
	},
	"MQ002": {
		"Name": "First Dive",
		"Stage": 1,
		"Description": {
			"01":"Enter the first level.",
		}
	},
	"MQ003": {
		"Name": "First Dive Complete",
		"Stage": 1,
		"Description": {
			"01":"Beat the first level",
		}
	},
}

var ActiveQuests: Dictionary = {}
var CompletedQuests: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
