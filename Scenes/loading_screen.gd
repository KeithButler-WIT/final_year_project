extends Control


var next_scene = Global.next_scene
var progress := []
var scene_load_status = 0

@onready var percentage_label = $VSplitContainer/Percentage
@onready var tip_label = $VSplitContainer/Tip
@onready var progress_bar = $VSplitContainer/ProgressBar

func _ready() -> void:
	next_scene = Global.next_scene
	ResourceLoader.load_threaded_request(next_scene)


func _process(delta: float) -> void:
	#ResourceLoader.load_threaded_request(next_scene)
	scene_load_status = ResourceLoader.load_threaded_get_status(next_scene, progress)
	percentage_label.text = str(floor(progress[0]*100)) + "%"
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(next_scene)
		Global.goto_scene(new_scene.resource_path)
