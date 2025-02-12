extends Control

@export var ButtonContainer : Control
@export var resume_button : Button
@export var quit_to_menu_button : Button
@export var quit_to_desktop_button : Button

#TODO: UPDATE LOOK


func _ready() -> void:
	_set_Button_signals()
	set_pivot_offset(size/2)
	_animate_on_load()


func _set_Button_signals():
	ButtonContainer.set_pivot_offset(ButtonContainer.size/2)
	for child in ButtonContainer.get_children():
		child.set_pivot_offset(child.size/2)
		child.connect("mouse_entered", _on_button_mouse_entered.bind(child.get_index()))
		child.connect("mouse_exited", _on_button_mouse_exited.bind(child.get_index()))


#func _process(delta: float) -> void:
	#if !OS.has_feature("standalone"):
		#if Input.is_key_pressed(KEY_ESCAPE):
			#_animate_on_load()


func _on_resume_button_pressed() -> void:
	_animate_on_resume()


func _on_quit_menu_button_pressed() -> void:
	Global.current_scene = "res://Scenes/main.tscn"
	Global.goto_scene("res://Scenes/main.tscn")


func _on_quit_desktop_button_pressed() -> void:
	get_tree().quit()


func _on_button_mouse_entered(index: int) -> void:
	var button = ButtonContainer.get_child(index)
	animate_scale(button, 1.1, 0.1)


func _on_button_mouse_exited(index: int) -> void:
	var button = ButtonContainer.get_child(index)
	animate_scale(button, 1, 0.1)


func animate_scale(button:Control, amount:float, time:float):
	var tween = get_tree().create_tween().bind_node(button)
	tween.tween_property(button, "scale", Vector2(amount,amount), time)


func _animate_on_load():
	var tween = get_tree().create_tween().bind_node(self)
	#tween.set_parallel(true)
	#tween.tween_property(self, "position", Vector2(position.x,position.y+400), 0.1)
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.1)
	tween.tween_property(self, "scale", Vector2(1,1), 0.1)


func _animate_on_resume():
	var tween = get_tree().create_tween().bind_node(self)
	tween.set_parallel(true)
	tween.tween_property(self, "position", Vector2(position.x,position.y+400), 0.1)
	tween.tween_property(self, "scale", Vector2(0,0), 0.2)
	if (tween.finished):
		tween.tween_callback(self.queue_free)
