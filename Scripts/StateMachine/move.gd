extends Node

var fsm: StateMachine

func enter():
	print("Hello from move!")
	await get_tree().create_timer(2.0).timeout
	exit()


func exit():
	# Go back to the last state
	fsm.back()


func _unhandled_key_input(event):
	if event.pressed:
		print("From move")
