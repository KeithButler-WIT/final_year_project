extends Node3D

@export var LEVEL_SCENE : PackedScene
@export var use_timer : bool = false
@export var wait_time: float = 5.0

@onready var timer = $LevelStartTimer
@onready var countdownLabel = $Control/ObjectiveCountdown


func _ready():
	countdownLabel.visible = false
	timer.wait_time = wait_time


func _process(_delta):
	# update ui countdown
	if not timer.paused and use_timer:
		countdownLabel.text = str(int(timer.time_left))


func load_level():
	print("Loading Level")
	#get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(LEVEL_SCENE.resource_path))
	#get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(LEVEL_SCENE.resource_path))
	#get_tree().root.change_scene_to_packed(LEVEL_SCENE)
	#ResourceLoader.load_threaded_request(LEVEL_SCENE.resource_path)
	Global.goto_scene(LEVEL_SCENE.resource_path)


func _on_level_start_timer_timeout():
	load_level()


func _on_level_start_area_body_entered(body):
	if body.is_in_group("player"):
		#print("body is in group")
		if use_timer:
			timer.start()
			countdownLabel.visible = true
		else:
			load_level()


func _on_level_start_area_body_exited(body):
	if body.is_in_group("player"):
		if use_timer:
			timer.stop()
			countdownLabel.visible = false
