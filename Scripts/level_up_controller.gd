extends Control


func _ready():
	pass

var simultaneous_scene = preload("res://levels/hub_world.tscn")

func _on_start_button_pressed():
	# Put your load scene here
	# Check the documentation https://docs.godotengine.org/en/stable/tutorials/scripting/change_scenes_manually.html
	get_tree().change_scene_to_packed(simultaneous_scene)


func _on_option_1_pressed():
	PlayerStats.level += 1
	PlayerStats.num_turrets_placeable += 1
	PlayerStats.max_health += 10
	$"../../level_up_menu/MainMenu".visible = false

func _on_option_2_pressed():
	PlayerStats.level += 1
	PlayerStats.max_health += 10
	PlayerStats.turret_damage *= 1.5
	$"../../level_up_menu/MainMenu".visible = false

func _on_option_3_pressed():
	PlayerStats.level += 1
	PlayerStats.max_health += 10
	PlayerStats.movement_speed *= 1.20
	$"../level_up_menu/MainMenu".visible = false
