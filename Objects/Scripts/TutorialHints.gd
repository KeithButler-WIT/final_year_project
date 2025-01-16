extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if (PlayerStats.missions_completed < 4):
		visible = true
	else:
		visible = false
