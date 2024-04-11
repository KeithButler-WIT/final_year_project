extends Node3D

# Spawn a single objective randomly in the world
# after objective completed spawn exit

func _process(_delta):
	update_exp_bar()

func update_exp_bar():
	$ExpUi/Bar.value = PlayerStats.experience
	$ExpUi/Bar.max_value = PlayerStats.exp_to_next_level
	$ExpUi/Label.text = "LEVEL " + str(PlayerStats.level)
