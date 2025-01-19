extends Control

@onready var option1 = $"AspectRatioContainer/MainContainer/VContainer/Option"
@onready var option2 = $"AspectRatioContainer/MainContainer/VContainer2/Option"
@onready var option3 = $"AspectRatioContainer/MainContainer/VContainer3/Option"

func _ready():
	option1.text = "Number of turrets + 1"
	option2.text = "Turret damage + 50%"
	option3.text = "MOVEMENT SPEED + 20%"
	visible = false

func get_upgrades():
	#TODO: check in filesystem for possible upgrades
	# randomily pick one
	# return and spawn in scene at players feetb
	pass

func _on_option_1_pressed():
	base_stat_increase()
	#TODO: spawn upgrade item instead
	PlayerStats.num_turrets_placeable += 1
	visible = false

func _on_option_2_pressed():
	base_stat_increase()
	#TODO: spawn upgrade item instead
	PlayerStats.turret_damage *= 1.5
	visible = false

func _on_option_3_pressed():
	base_stat_increase()
	#TODO: spawn upgrade item instead
	PlayerStats.movement_speed *= 1.20
	visible = false

func base_stat_increase():
	#PlayerStats.level += 1
	PlayerStats.max_health += 10
