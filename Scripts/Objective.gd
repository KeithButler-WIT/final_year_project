extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $Timer.is_stopped:
		print($Timer.time_left)


func _on_timer_timeout():
	print("Object completed")
	queue_free()


func _on_area_3d_body_entered(body):
	print("Timer started")
	$Timer.start()


func _on_area_3d_body_exited(body):
	print("Timer stopped")
	$Timer.stop()
