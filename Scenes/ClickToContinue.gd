extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var scene = preload("res://Scenes/main.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	elif Input.is_anything_pressed():
		get_tree().change_scene_to_packed(scene)

#func _unhandled_key_input(event): 
	#if event.is_action("ui_cancel") :
		#get_tree().quit()
	#elif event.is_pressed():
		#get_tree().change_scene_to_packed(scene)
