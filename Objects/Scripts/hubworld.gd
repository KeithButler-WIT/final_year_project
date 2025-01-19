extends Node3D


func _ready():
	PlayerStats.load_game() # TODO: Load on start not of return
	PlayerStats.reset() # TODO: reset on return
	Dialogic.start("hubworld")
