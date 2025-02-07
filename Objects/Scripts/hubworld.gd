extends Node3D

@onready var questList:Control = $QuestList
var main_ui = []

func _ready():
	PlayerStats.load_game() # TODO: Load on start not of return
	call_deferred("PlayerStats.save_game")
	PlayerStats.reset() # TODO: reset on return
	Dialogic.start("hubworld")
	QuestManager.addQuest("MQ001")
	
	main_ui.append(questList)


func _process(delta: float) -> void:
	if !OS.has_feature("standalone"):
		if Input.is_key_pressed(KEY_O):
			print("Saving")
			PlayerStats.save_game()
		if Input.is_key_pressed(KEY_P):
			print("LOADING")
			PlayerStats.load_game()


func toggle_main_ui():
	for ui in main_ui:
		ui.visible = !ui.visible
