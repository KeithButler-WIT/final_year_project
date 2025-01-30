extends Node3D

@export var packed_enemy: Array[PackedScene]
@onready var timer = $Timer
@onready var camera : Camera3D = get_node("../Player/CameraArm/Camera")

var enemies_remaining_to_spawn
var enemies_killed_this_wave = 0
var enemies_killed_total = 0

# list of all wave nodes 
var waves
var current_wave: Wave
var current_wave_number = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	for enemy in packed_enemy:
		ResourceLoader.load_threaded_request(enemy.resource_path)
	waves = $"Waves".get_children()
	start_next_wave()
	_update_timer_wait()

func _update_timer_wait():
	if timer.wait_time < 1:
		timer.wait_time = 1
	timer.wait_time = timer.wait_time / PlayerStats.player_skill #TODO: scale delending on player skill # / PlayerStats.player_skill

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
	_update_timer_wait()
	if enemies_remaining_to_spawn:
		ResourceLoader.load_threaded_request(packed_enemy[0].resource_path)
		var enemy_scene = ResourceLoader.load_threaded_get(packed_enemy[0].resource_path)
		var enemy = enemy_scene.instantiate()
		enemy.position = get_random_position_off_screen()
		connect_to_enemy_signals(enemy)
		get_tree().current_scene.add_child(enemy)
		#enemies_remaining_to_spawn -= 1
	else:
		if enemies_killed_this_wave == current_wave.num_enemies:
			start_next_wave()

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

	if rng.randi() % 2 == 0:
		# spawn at top or bottom
		randx = int(rng.randi_range(0, screensize.x))
		randz = -distance_outside_screen if rng.randi() % 2 == 0 else screensize.y + distance_outside_screen
	else:
		# spawn at left or right
		randz = int(rng.randi_range(0, screensize.y))
		randx = -distance_outside_screen if rng.randi() % 2 == 0 else screensize.x + distance_outside_screen

	return Vector3(randx, 3, randz)
