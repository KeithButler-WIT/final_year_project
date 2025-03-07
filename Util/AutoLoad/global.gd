extends Node

const LOADING_SCREEN_PATH : String = "res://Scenes/loading_screen.tscn"

var current_scene = null
var next_scene = null


func _ready():
	ResourceLoader.load_threaded_request(LOADING_SCREEN_PATH)
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)


func goto_loading_screen(scene:String) -> void:
	next_scene = scene
	goto_scene(LOADING_SCREEN_PATH)


#func goto_loading_screen(next_scene:PackedScene) -> void:
	#next_scene = scene
	#goto_scene(LOADING_SCREEN_PATH)


func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	ResourceLoader.load_threaded_request(path)
	call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	print(get_tree().current_scene)
	get_tree().current_scene.free()

	# Load the new scene.
	#var progress = []
	#ResourceLoader.load_threaded_get_status(path, progress)
	#print(progress[0]*100)
	#if progress[0] == 1:
		#var s = ResourceLoader.load_threaded_get(path)
	# Instance the new scene.
	current_scene = load(path).instantiate()
	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
