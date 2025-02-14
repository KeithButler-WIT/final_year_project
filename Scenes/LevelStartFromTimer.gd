extends Node3D

@export var LEVEL_SCENE : String
@export var use_timer : bool = false

@onready var timer := $LevelStartTimer
@onready var countdownLabel := $Control/ObjectiveCountdown

func _ready():
	countdownLabel.visible = false
	if !use_timer:
		timer.wait_time = 0.001


func _process(_delta):
	# update ui countdown
	if not timer.paused:
		countdownLabel.text = str(int(timer.time_left))


func _on_level_start_timer_timeout():
	print("LOAD THE LEVEL: TIMER TIMEOUT")
	#print(LEVEL_SCENE.resource_path)
	Global.goto_scene(load(LEVEL_SCENE).resource_path)


func _on_level_start_area_body_entered(_body):
	print("Level area entered")
	timer.start()
	#ResourceLoader.load_threaded_request(LEVEL_SCENE.resource_path)
	# Load level in background
	countdownLabel.visible = true


func _on_level_start_area_body_exited(_body):
	print("Level Area Left")
	timer.stop()
	countdownLabel.visible = false
