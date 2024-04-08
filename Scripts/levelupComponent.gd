extends Node3D


var current_level = PlayerStats.level

# Called when the node enters the scene tree for the first time.
func _ready():
	#if ($"../level_up_menu"):
		#$"../level_up_menu/MainMenu".visible = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (PlayerStats.experience >= PlayerStats.exp_to_next_level):
		PlayerStats.level += 1
	if (current_level < PlayerStats.level):
		current_level = PlayerStats.level
		PlayerStats.experience = 0
		PlayerStats.exp_to_next_level *= 1.5
		print("Exp ", PlayerStats.experience)
		print("Exp to get ", PlayerStats.exp_to_next_level)
		print("Level ", PlayerStats.level)
		# open level up menu
		if ($"../level_up_menu" and $"../level_up_menu/MainMenu".visible != true):
			print("LEVELING UP")
			$"../level_up_menu/MainMenu".visible = true
