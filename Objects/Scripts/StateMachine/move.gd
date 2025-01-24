extends Node

var fsm: StateMachine

var SPEED = PlayerStats.starting_movement_speed 

@onready var PLAYER = $"../.."
@onready var CHARACTER = $"../../Character"
@onready var ANIMATIONPLAYER = $"../../Character/AnimationPlayer"

func enter():
	print("Move State!")

#func move():
func exit():
	# Go back to the last state
	fsm.back()

func _physics_process(_delta):
	SPEED = PlayerStats.movement_speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (PLAYER.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		PLAYER.velocity.x = direction.x * SPEED
		PLAYER.velocity.z = direction.z * SPEED
	else:
		PLAYER.velocity.x = move_toward(PLAYER.velocity.x, 0, SPEED)
		PLAYER.velocity.z = move_toward(PLAYER.velocity.z, 0, SPEED)

	PLAYER.move_and_slide()

	if Input.is_action_pressed("move_left"): 
		CHARACTER.flip_h = false
		ANIMATIONPLAYER.play("walk_left")
	elif Input.is_action_pressed("move_right"):
		CHARACTER.flip_h = true
		ANIMATIONPLAYER.play("walk_right")
	elif Input.is_action_pressed("move_up"):
		ANIMATIONPLAYER.play("walk_up")
	elif Input.is_action_pressed("move_down"):
		ANIMATIONPLAYER.play("walk_down")
	else:
		#ANIMATIONPLAYER.stop()
		ANIMATIONPLAYER.play("idle")
		exit()
