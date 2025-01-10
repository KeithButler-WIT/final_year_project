extends CharacterBody3D

@onready var gun_controller = $GunController

var SPEED = PlayerStats.movement_speed 
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var packet_turret : PackedScene
var turrets = []
var can_place_turret : bool = true
var canBeDamaged :bool = true

func _ready():
	#$Character/AnimationPlayer.play("idle")
	pass

func _physics_process(delta):
	SPEED = PlayerStats.movement_speed
	# Movement
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	if Input.is_action_pressed("move_left"): 
		$Character.flip_h = false
		$Character/AnimationPlayer.play("walk_left")
	elif Input.is_action_pressed("move_right"):
		$Character.flip_h = true
		$Character/AnimationPlayer.play("walk_right")
	elif Input.is_action_pressed("move_up"):
		$Character/AnimationPlayer.play("walk_up")
	elif Input.is_action_pressed("move_down"):
		$Character/AnimationPlayer.play("walk_down")
	else:
		#$Character/AnimationPlayer.stop()
		$Character/AnimationPlayer.play("idle")
	
	# Shooting
	if Input.is_action_pressed("primary_action"):
		gun_controller.shoot()
	if Input.is_action_pressed("turret_place"):
		place_turret()
	
	# TODO: run every 0.5 seconds
	_update_health_bar()


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
