extends Node

var fsm: StateMachine

func enter():
	print("Idle State!")
	# Exit 2 seconds later
	#await get_tree().create_timer(1.0).timeout
	
	# On button press move


func exit(next_state):
	fsm.change_to(next_state)


func _unhandled_key_input(event):
	if event.pressed:
		exit("move")
		
