extends Control

@onready var questList = $Panel/VSplitContainer/ItemList
@onready var description = $Panel/DescriptionLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	questList.clear()
	description.clear()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	updateQuestList()


func updateQuestList():
	questList.clear()
	if QuestManager.ActiveQuests.keys().size() > 0:
		for i in QuestManager.ActiveQuests.keys():
			questList.add_item(QuestManager.ActiveQuests[i]["Name"])
			#questList.set_item_text(i, str(QuestManager.ActiveQuests[i]["Name"]) + "\n\t - " + str(QuestManager.ActiveQuests[i]["Description"]))


func _on_item_list_item_selected(index: int) -> void:
	questList.deselect_all()
	
	var questID = QuestManager.ActiveQuests.keys()[index]
	var currentStage: String = str(QuestManager.ActiveQuests[questID]["Stage"])
	description.text = QuestManager.ActiveQuests[questID]["Description"]["0" + currentStage]
