extends Node

var fsm: StateMachine

@onready var PLAYER = $"../.."
@onready var CHARACTER = $"../../Character"
@onready var ANIMATIONPLAYER = $"../../Character/AnimationPlayer"

const JUMP_VELOCITY = 4.5

func enter():
	print("Idle State!")
	# Exit 2 seconds later
	#await get_tree().create_timer(1.0).timeout


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept") and PLAYER.is_on_floor():
		PLAYER.velocity.y = JUMP_VELOCITY

func exit(next_state):
	fsm.change_to(next_state)


func _unhandled_key_input(event):
	if event.pressed:
		exit("move")
		
