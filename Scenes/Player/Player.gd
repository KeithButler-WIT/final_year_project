extends CharacterBody3D

@onready var gun_controller = $GunController

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var packet_turret : PackedScene
var turrets = []
var can_place_turret : bool = true

func _ready():
	$Character/AnimationPlayer.play("idle")

func _physics_process(delta):
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
	
	if (direction.x > 0):
		$Character.flip_h = false
		$Character/AnimationPlayer.play("walk_left")
	if (direction.x < 0):
		$Character.flip_h = true
		$Character/AnimationPlayer.play("walk_right")
	if (direction.z > 0):
		$Character/AnimationPlayer.play("walk_forward")
	if (direction.z < 0):
		$Character/AnimationPlayer.play("walk_down")
	if (direction == Vector3.ZERO):
		$Character/AnimationPlayer.play("idle")
	
	# Shooting
	if Input.is_action_pressed("primary_action"):
		gun_controller.shoot()
	if Input.is_action_pressed("turret_place"):
		place_turret()


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
