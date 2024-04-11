extends Node3D

const LEVEL_SCENE_PATH : String = "res://levels/sandbox.tscn"


func _ready():
	PlayerStats.load_game()


# Save when loading into level

func _on_level_start_timer_timeout():
	print("LOAD THE LEVEL: TIMER TIMEOUT")
	# Obtain the resource now that we need it
	# Save player stats
	
	print("SAVING")
	PlayerStats.save_game()
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(LEVEL_SCENE_PATH))


func _on_level_start_area_body_entered(body):
	print("Level area entered")
	$LevelStartTimer.start()
	ResourceLoader.load_threaded_request(LEVEL_SCENE_PATH)
	# Load level in background
	# update ui countdown


func _on_level_start_area_body_exited(body):
	print("Level Area Left")
	$LevelStartTimer.stop()
	# Pause ui countdown
