extends Node3D

@onready var questList:Control = $QuestList
var main_ui = []

func _ready():
	PlayerStats.load_game() # TODO: Load on start not of return
	PlayerStats.reset() # TODO: reset on return
	Dialogic.start("hubworld")
	QuestManager.addQuest("MQ001")
	
	main_ui.append(questList)


func toggle_main_ui():
	for ui in main_ui:
		ui.visible = !ui.visible
