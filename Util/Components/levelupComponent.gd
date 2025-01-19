extends Node3D


var current_level = PlayerStats.level
var level_up_node = "../../Control/level_up_menu"

# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_node_or_null(level_up_node) != null):
		$"../../Control/level_up_menu".visible = false


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
		print("Level up menu: ",get_node_or_null(level_up_node))
		# open level up menu
		if (get_node_or_null(level_up_node) != null and $"../../Control/level_up_menu".visible == false):
			print("LEVELING UP")
			$"../../Control/level_up_menu".visible = true
