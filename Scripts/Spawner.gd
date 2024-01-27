extends Node3D

@export var packed_enemy: PackedScene
@onready var timer = $Timer
@onready var camera : Camera3D = get_node("/root/Level/Player/Camera")

var enemies_remaining_to_spawn
var enemies_killed_this_wave = 0
var enemies_killed_total = 0

# list of all wave nodes 
var waves
var current_wave: Wave
var current_wave_number = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	waves = $"Waves".get_children()
	start_next_wave()
	
func start_next_wave():
	enemies_killed_this_wave = 0
	current_wave_number += 1
	if current_wave_number < waves.size():
		current_wave = waves[current_wave_number]
		enemies_remaining_to_spawn = current_wave.num_enemies
		timer.wait_time = current_wave.seconds_between_spawns
		timer.start()

func connect_to_enemy_signals(enemy: Enemy):
	var health: HealthComponent = enemy.get_node("HealthComponent")
	health.died_signal.connect(_on_enemy_health_died_signal)

func _on_enemy_health_died_signal():
	enemies_killed_this_wave += 1
	enemies_killed_total += 1
	#("detected enemy death")

func _on_timer_timeout():
	if enemies_remaining_to_spawn:
		var new_enemy = packed_enemy.instantiate()
		new_enemy.position = get_random_position_off_screen()
		print(new_enemy.position)
		connect_to_enemy_signals(new_enemy)
		var scene_root = get_parent()
		scene_root.add_child(new_enemy)
		enemies_remaining_to_spawn -= 1
	else:
		if enemies_killed_this_wave == current_wave.num_enemies:
			start_next_wave()

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

	if rng.randi() % 2 == 0:
		# spawn at top or bottom
		randx = int(rng.randi_range(0, screensize.x))
		randz = -distance_outside_screen if rng.randi() % 2 == 0 else screensize.y + distance_outside_screen
	else:
		# spawn at left or right
		randz = int(rng.randi_range(0, screensize.y))
		randx = -distance_outside_screen if rng.randi() % 2 == 0 else screensize.x + distance_outside_screen

	return Vector3(randx, 2, randz)
