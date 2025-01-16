extends Node3D


func _ready():
	PlayerStats.load_game()
	PlayerStats.reset()
	Dialogic.start("hubworld")
