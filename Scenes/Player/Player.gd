extends CharacterBody3D

@onready var gun_controller = $GunController

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var packet_turret : PackedScene
var turrets = []
var can_place_turret : bool = true
var canBeDamaged :bool = true

func _ready():
	pass

func _physics_process(_delta):
	# TODO: run every 0.5 seconds
	_update_health_bar()
	

func shoot():
	# Shooting
	if Input.is_action_pressed("primary_action"):
		gun_controller.shoot()
	if Input.is_action_pressed("turret_place"):
		place_turret()

#@onready var health_bar = $HealthBar/SubViewport/health_bar
func _update_health_bar():
	%health_bar.max_value = PlayerStats.max_health
	%health_bar.min_value = 0
	%health_bar.value = PlayerStats.current_health


func place_turret():
	if (can_place_turret):
		var new_turret = packet_turret.instantiate()
		new_turret.global_transform = global_transform
		var scene_root = get_tree().root#.get_children()[0]
		scene_root.add_child(new_turret)
		if (turrets.size() == PlayerStats.num_turrets_placeable):
			scene_root.remove_child(turrets[0])
			turrets.pop_front() # remove oldest turret
			turrets.append(new_turret)
			print("Turret Size: ", turrets.size())
			print("Max Turrets reached, replacing oldest one")
		else:
			turrets.append(new_turret)
			print("Spawning turret")
		can_place_turret = false
	else:
		print("Turret on cooldown")


func _on_turret_place_timer_timeout():
	can_place_turret = true


func take_hit(damage):
	# TODO: Add cooldown to being hit
	if canBeDamaged:
		PlayerStats.current_health -= damage
		canBeDamaged = false
		print("HP: ", PlayerStats.current_health,"/",PlayerStats.max_health)
		PlayerStats.decrease_skill(1)
	
	if PlayerStats.current_health <= 0:
		die()

const LEVEL_SCENE_PATH : String = "res://levels/hub_world.tscn"

func die():
	print("GAME OVER")
	ResourceLoader.load_threaded_request(LEVEL_SCENE_PATH)
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(LEVEL_SCENE_PATH))
	#emit_signal("player_died_signal")
	#visible = false
	#queue_free()
	#Global.goto_scene("res://levels/hub_world.tscn")

func _on_can_be_damaged_timer_timeout():
	canBeDamaged = true
