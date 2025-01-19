extends Node3D

# Spawn a single objective randomly in the world
# after objective completed spawn exit

@export var missionEnd : PackedScene
@export var exitLadder : PackedScene


func _ready():
	pass


func _process(_delta):
	update_exp_bar()
	update_hp_bar()


func update_exp_bar():
	$Control/ExpUi/Bar.value = PlayerStats.experience
	$Control/ExpUi/Bar.max_value = PlayerStats.exp_to_next_level
	$Control/ExpUi/Label.text = "LEVEL " + str(PlayerStats.level)


func update_hp_bar():
	$Control/HpUi/Bar.value = PlayerStats.current_health
	$Control/HpUi/Bar.max_value = PlayerStats.max_health
	$Control/HpUi/Label.text = str(PlayerStats.current_health) + "/" + str(PlayerStats.max_health)


func _on_objective_complete() -> void:
	#TODO: Spawn level exit
	var player = $Player.position
	# Continue Deeper
	var mission_end = missionEnd.instantiate()
	mission_end.position = Vector3(player.x+10, player.y, player.z)
	add_child(mission_end)
	# Back To Hub
	var exit_ladder = exitLadder.instantiate()
	mission_end.position = Vector3(player.x-10, player.y, player.z)
	add_child(exit_ladder)
