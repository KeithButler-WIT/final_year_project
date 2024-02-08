extends CharacterBody3D

@onready var gun_controller = $GunController

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var packet_turret : PackedScene
var turret_placed : bool = false

func _physics_process(delta):
	# Movement
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Shooting
	if Input.is_action_pressed("primary_action"):
		gun_controller.shoot()
		place_turret()


func place_turret():
	if (!turret_placed):
		var new_turret = packet_turret.instantiate()
		new_turret.global_transform = global_transform
		var scene_root = get_tree().root#.get_children()[0]
		scene_root.add_child(new_turret)
		turret_placed = true
		print("Spawning turret")

