extends Node3D

# Spawn a single objective randomly in the world
# after objective completed spawn exit

@export var levelLoader : PackedScene
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
	print("ENEMIES: ", get_tree().get_nodes_in_group("enemy").size())
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
	var level_loader = levelLoader.instantiate()
	level_loader.position = Vector3(player.x+10, player.y, player.z)
	var tween = get_tree().create_tween().bind_node(self)
	#tween.set_parallel(true)
	tween.tween_property(level_loader, "scale", Vector3(0,1,0), 0.0001)
	tween.tween_property(level_loader, "scale", Vector3(1,1,1), 1)
	#mission_end.LEVEL_SCENE = preload("res://Scenes/level_01.tscn")
	#if get_tree().current_scene.name.contains("X"): # Infinite level loopd
		#mission_end.LEVEL_SCENE = preload("res://Scenes/level_X.tscn")
	#print(get_tree().current_scene.name[15])
	var current_name = get_tree().current_scene.name
	var current_num = current_name.substr(5).to_int()
	print("CURRENT NAME	: ", current_name)
	print("CURRENT NUMBER	: ", current_num)
	# TODO change to path
	level_loader.LEVEL_SCENE = "res://Scenes/level_0%d%s" % [current_num+1, ".tscn"]
	add_child(level_loader)
	# Back To Hub
	var exit_ladder = exitLadder.instantiate()
	level_loader.position = Vector3(player.x-10, player.y, player.z)
	add_child(exit_ladder)
	#var tween = get_tree().create_tween().bind_node(self)
	##tween.set_parallel(true)
	#tween.tween_property(mission_end, "modulate", Color.RED, 0.1)


func spawn_objective():
	var player_position = $Player.position
	var objective = PackedObjective.instantiate()
	objective.position = Vector3(randi_range(player_position.x-100,player_position.x+100),0,randi_range(player_position.y-100,player_position.y+100))
	objective.unique_name_in_owner = true
	print(objective.position)
	add_child(objective)
	var obj = get_node("Objective")
	obj.complete.connect(_on_objective_complete)
