extends Node3D

# Spawn a single objective randomly in the world
# after objective completed spawn exit

@export var missionEnd : PackedScene
@export var exitLadder : PackedScene
@export var PackedObjective : PackedScene

@onready var exp_bar = $Control/ExpUi/Bar
@onready var exp_label = $Control/ExpUi/Label
@onready var hp_bar = $Control/HpUi/Bar
@onready var hp_label = $Control/HpUi/Label

@onready var timer = $Timer
var time_start = 0

func _ready():
	time_start = Time.get_ticks_msec()
	spawn_objective()


var sec_to_min = func(sec):
	return sec / 60

var msec_to_min = func(msec):
	return msec / 60  / 60 / 60


func _process(_delta):
	update_exp_bar()
	update_hp_bar()
	#print("Time Left: %d" % msec_to_min.call(Time.get_ticks_msec() - time_start))
	#match msec_to_min.call(Time.get_ticks_msec() - time_start):
		#0: 
			#print("ZERO MINUTE")
		#1:
			#print("ONE MINUTE")

	#print("Time Left: %d" % sec_to_min.call(timer.time_left))sw

# ON TIMEOUT SPAWN BIG BOSS
# VARIOUS TIMERS TO SPAWN MINI BOSSES
# TIMER ON WAVES SPAWNING

func update_exp_bar():
	exp_bar.value = PlayerStats.experience
	exp_bar.max_value = PlayerStats.exp_to_next_level
	exp_label.text = "LEVEL " + str(PlayerStats.level)


func update_hp_bar():
	hp_bar.value = PlayerStats.current_health
	hp_bar.max_value = PlayerStats.max_health
	hp_label.text = str(PlayerStats.current_health) + "/" + str(PlayerStats.max_health)


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


func spawn_objective():
	var objective = PackedObjective.instantiate()
	objective.position = Vector3(randi_range(-100,100),0,randi_range(-100,100))
	objective.unique_name_in_owner = true
	print(objective.position)
	add_child(objective)
