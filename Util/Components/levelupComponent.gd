extends Node3D


var current_level = PlayerStats.level
var level_up_node = "../../Control/level_up_menu"

# Called when the node enters the scene tree for the first time.
func _ready():
	if (get_node_or_null(level_up_node) != null):
		$"../../Control/level_up_menu".visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	level_up()

var debug = func():
	print("Exp ", PlayerStats.experience)
	print("Exp to get ", PlayerStats.exp_to_next_level)
	print("Level ", PlayerStats.level)
	print("Level up menu: ",get_node_or_null(level_up_node))


func level_up():
	var increase_level = func(overflow_exp = 0):
		if (PlayerStats.experience >= PlayerStats.exp_to_next_level):
			overflow_exp = PlayerStats.experience - PlayerStats.exp_to_next_level
			PlayerStats.experience = overflow_exp
			PlayerStats.level += 1
			PlayerStats.exp_to_next_level *= 1.5
			if overflow_exp >= 0:
				return overflow_exp
		return 0
	var overflow_exp = increase_level.call()
	while overflow_exp > PlayerStats.exp_to_next_level:
		overflow_exp = increase_level.call(overflow_exp)
		if !OS.has_feature("standalone"):
			print("Overflow EXP: %f" % overflow_exp)
	if current_level < PlayerStats.level and !$"../../Control/level_up_menu".visible:
		if !OS.has_feature("standalone"):
			debug.call()
		var levels_to_give = PlayerStats.level - current_level
		if levels_to_give > 0:
			if (get_node_or_null(level_up_node) != null and levels_to_give > 0):
				$"../../Control/level_up_menu".visible = true
				current_level += 1
				levels_to_give = PlayerStats.level - current_level
