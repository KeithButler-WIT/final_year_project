extends BaseLevel

# Spawn a single objective randomly in the world
# after objective completed spawn exit


func _ready():
	time_start = Time.get_ticks_msec()
	spawn_objective()


func _process(delta: float) -> void:
	time_elapsed += delta
	#print("ENEMIES: ", get_tree().get_nodes_in_group("enemy").size())
	update_exp_bar()
	update_hp_bar()
	#print("Time Left: %d" % msec_to_min.call(Time.get_ticks_msec() - time_start))
	#match msec_to_min.call(Time.get_ticks_msec() - time_start):
		#0: 
			#print("ZERO MINUTE")
		#1:
			#print("ONE MINUTE")

	#print("Time Left: %d" % sec_to_min.call(timer.time_left))

# ON TIMEOUT SPAWN BIG BOSS
# VARIOUS TIMERS TO SPAWN MINI BOSSES
# TIMER ON WAVES SPAWNING


func _spawn_next_level_exit() -> void:
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
	if !level_loader.LEVEL_SCENE:
		level_loader.LEVEL_SCENE = "res://Scenes/hub_world.tscn"
	add_child(level_loader)
	
func _spawn_hub_level_exit() -> void:
	var player = $Player.position
	var exit_ladder = exitLadder.instantiate()
	exit_ladder.position = Vector3(player.x-10, player.y, player.z)
	add_child(exit_ladder)
	#var tween = get_tree().create_tween().bind_node(self)
	#tween.set_parallel(true)
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


func _on_objective_complete() -> void:
	objectives_completed += 1
	if objectives_completed >= objectives_needed:
		_spawn_next_level_exit()
		_spawn_hub_level_exit()
	else:
		#TODO: Update UI to show how many left needed to progress onto next level
		pass


func _on_spawn_exit_timer_timeout() -> void:
	_spawn_next_level_exit()
	_spawn_hub_level_exit()


func _on_spawn_objective_timer_timeout() -> void:
	spawn_objective()
