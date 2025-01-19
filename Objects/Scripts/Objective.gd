extends Node3D

signal complete

@onready var countdownTimer = $Control/ObjectiveCountdown
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	countdownTimer.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not timer.is_stopped:
		countdownTimer.text = str(int(timer.time_left))


func _on_timer_timeout():
	print("Objective completed")
	countdownTimer.visible = false
	complete.emit() # Send to parent
	queue_free()


func _on_area_3d_body_entered(_body):
	print("Objective timer started")
	timer.start()
	countdownTimer.visible = true


func _on_area_3d_body_exited(_body):
	print("Objective timer stopped")
	timer.stop()
