extends Node

var fsm: StateMachine

func enter():
	print("Hello from idle!")
	# Exit 2 seconds later
	await get_tree().create_timer(2.0).timeout
	exit("move")
	# On button press move


func exit(next_state):
	fsm.change_to(next_state)


func _unhandled_key_input(event):
	if event.pressed:
		print("From idle")
		
