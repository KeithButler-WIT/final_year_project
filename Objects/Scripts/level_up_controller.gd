extends Control

@onready var option1 = $"AspectRatioContainer/MainContainer/VContainer/Option"
@onready var option2 = $"AspectRatioContainer/MainContainer/VContainer2/Option"
@onready var option3 = $"AspectRatioContainer/MainContainer/VContainer3/Option"

@onready var upgrades
@onready var upgrade_1
@onready var upgrade_2
@onready var upgrade_3


func _ready():
	#option1.text = "Number of turrets + 1"
	#option2.text = "Turret damage + 50%"
	#option3.text = "MOVEMENT SPEED + 20%"
	upgrades = Utils.get_all_files("res://Util/Strategy/temporary")
	visible = false


func get_random_upgrade() -> Resource:
	# randomily pick one
	# return and spawn in scene on player
	randomize()
	if upgrades:
		upgrades.shuffle()
		return load(upgrades[0]).new()
	return null


func _on_visibility_changed() -> void:
	if upgrades:
		#set_script(get_random_upgrades()).apply_upgrade()
		upgrade_1 = get_random_upgrade()
		option1.text = upgrade_1.description
		upgrade_2 = get_random_upgrade()
		option2.text = upgrade_2.description
		upgrade_3 = get_random_upgrade()
		option3.text = upgrade_3.description


func _on_option_1_pressed():
	base_stat_increase()
	upgrade_1.apply_upgrade(%Player)
	#option1.text = upgrade_1.description
	#TODO: spawn upgrade item insteadss
	#PlayerStats.num_turrets_placeable += 1


func _on_option_2_pressed():
	base_stat_increase()
	upgrade_2.apply_upgrade(%Player)
	#TODO: spawn upgrade item instead
	#PlayerStats.turret_damage *= 1.5


func _on_option_3_pressed():
	base_stat_increase()
	upgrade_3.apply_upgrade(%Player)
	#TODO: spawn upgrade item instead
	#PlayerStats.movement_speed *= 1.20


func base_stat_increase():
	#PlayerStats.level += 1
	PlayerStats.max_health += 10
	PlayerStats.current_health += 10



func _on_option_button_up() -> void:
	visible = false
