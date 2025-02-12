extends Node3D

@onready var questList:Control = $QuestList
var main_ui = []
@export var pause_menu: PackedScene

func _ready():
	PlayerStats.load_game() # TODO: Load on start not of return
	call_deferred("PlayerStats.save_game")
	PlayerStats.reset() # TODO: reset on return
	Dialogic.start("hubworld")
	QuestManager.addQuest("MQ001")
	
	main_ui.append(questList)

var time_elapsed = 0.0

func _process(delta: float) -> void:
	time_elapsed += delta
	if !OS.has_feature("standalone"):
		if Input.is_key_pressed(KEY_O):
			print("Saving")
			PlayerStats.save_game()
		if Input.is_key_pressed(KEY_P):
			print("LOADING")
			PlayerStats.load_game()

	if Input.is_action_just_pressed("ui_cancel"):
		if has_node("PauseMenu"):
			#await get_tree().create_timer(2).timeout
			if time_elapsed >= 0.5:
				time_elapsed = 0.0
				get_node("PauseMenu").queue_free()
		else:
			if time_elapsed >= 0.5:
				time_elapsed = 0.0
				print("PAUSING")
				var menu = pause_menu.instantiate()
				add_child(menu)


func toggle_main_ui():
	for ui in main_ui:
		ui.visible = !ui.visible
