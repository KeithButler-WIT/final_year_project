extends Node3D

# Spawn a single objective randomly in the world
# after objective completed spawn exit

func _process(_delta):
	$ExpUi/Bar.value = PlayerStats.experience
	$ExpUi/Bar.max_value = PlayerStats.exp_to_next_level
	$ExpUi/Label.text = "LEVEL " + str(PlayerStats.level)
