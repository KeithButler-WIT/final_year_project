extends Node3D

@export var LEVEL_SCENE : PackedScene

@onready var timer = $LevelStartTimer
@onready var countdownLabel = $Control/ObjectiveCountdown

func _ready():
	countdownLabel.visible = false


func _process(delta):
	# update ui countdown
	if not timer.paused:
		countdownLabel.text = str(int(timer.time_left))


func _on_level_start_timer_timeout():
	# Obtain the resource now that we need it
	# Save player stats
	
	print("SAVING")
	PlayerStats.save_game()
	print("LOAD THE LEVEL: TIMER TIMEOUT")
	#get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(LEVEL_SCENE.resource_path))
	get_tree().root.change_scene_to_packed(LEVEL_SCENE)

func _on_level_start_area_body_entered(body):
	print("Level area entered")
	timer.start()
	#ResourceLoader.load_threaded_request(LEVEL_SCENE.resource_path)
	# Load level in background
	countdownLabel.visible = true


func _on_level_start_area_body_exited(body):
	print("Level Area Left")
	timer.stop()
	countdownLabel.visible = false
