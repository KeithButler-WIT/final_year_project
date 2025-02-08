extends Node3D


@export var spawns : Array[SpawnInfo] = []

@onready var player = %Player
@onready var camera : Camera3D = get_node("../Player/CameraArm/Camera")

var time = 0


func _on_timer_timeout() -> void:
	time += 1
	var enemy_spawns = spawns
	for spawn in enemy_spawns:
		if time >= spawn.time_start and time <= spawn.time_end:
			if spawn.spawn_delay_counter < spawn.enemy_spawn_delay:
				spawn.spawn_delay_counter += 1
			else:
				spawn.spawn_delay_counter = 0
				var new_enemy = load(spawn.enemy.resource_path)
				var counter = 0
				while counter < spawn.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.position = get_random_position_off_screen()
					connect_to_enemy_signals(enemy_spawn)
					get_tree().current_scene.add_child(enemy_spawn)
					counter += 1


func connect_to_enemy_signals(enemy: Enemy):
	var health: HealthComponent = enemy.get_node("HealthComponent")
	health.died_signal.connect(_on_enemy_health_died_signal)

func _on_enemy_health_died_signal():
	PlayerStats.total_kills += 1
	#enemies_killed_this_wave += 1
	#enemies_killed_total += 1
	#("detected enemy death")


#FIXME: Enemies spawning too close to player
func get_random_position_off_screen() -> Vector3 :
	var randx
	var randz
	var distance_outside_screen := 10
	var screensize
	# Globals.camera doesn't exist when testing scene
	if weakref(camera).get_ref():
		screensize = camera.get_viewport().size
	else:
		screensize = get_viewport().size

	var rng := RandomNumberGenerator.new()
	rng.randomize()
	#match ["up","down","left","right"].pick_random():
	match rng.randi_range(0,3):
		0: # TOP
			randx = player.global_position.x + screensize.x/50
			randz = player.global_position.z + int(rng.randi_range(0, screensize.y/50))
		1: # BOTTOM
			randx = player.global_position.x - screensize.x/50
			randz = player.global_position.z - int(rng.randi_range(0, screensize.y/50))
		2: # LEFT
			randx = player.global_position.x - int(rng.randi_range(0, screensize.x/50))
			randz = player.global_position.z + screensize.y/50
		3: # RIGHT
			randx = player.global_position.x + int(rng.randi_range(0, screensize.x/50))
			randz = player.global_position.z - screensize.y/50

	return Vector3(randx, 3, randz)
