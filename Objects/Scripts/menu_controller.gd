extends Control
# Please check the documentation about
# Displayserver class : https://docs.godotengine.org/en/stable/classes/class_displayserver.html

#--
# Check out Colorblind addon for godot : https://github.com/paulloz/godot-colorblindness
#--

@onready var Resolution_ob = get_node("%Resolution_Optionbutton")
@onready var OptionContainer = get_node("%OptionContainer")
@onready var MainContainer = get_node("%MainContainer")

# Config file
# Move it into a singleton 
var SettingsFile = ConfigFile.new()
#--
var Vsync : int = 0
# I'm a Vector3 instead of 3 var float
# - x : General , y : Music , z : SFX
var Audio : Vector3 = Vector3(70.0,70.0,70.0)


func _get_resolution(index) -> Vector2i:
	var resolution_arr = Resolution_ob.get_item_text(index).split("x")
	return Vector2i(int(resolution_arr[0]),int(resolution_arr[1]))

func _check_resolution( resolution : Vector2i):
	for i in Resolution_ob.get_item_count() :
		if _get_resolution(i) == resolution :
			return i

func _first_time() -> void:
	DisplayServer.window_set_size(DisplayServer.screen_get_size())
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	DisplayServer.window_set_vsync_mode(Vsync)
	Resolution_ob.select(_check_resolution(DisplayServer.screen_get_size()))
	# -- Video
	SettingsFile.set_value("VIDEO","Resolution",_get_resolution(Resolution_ob.get_index()))
	SettingsFile.set_value("VIDEO","Vsync",Vsync)
	SettingsFile.set_value("VIDEO","Window Mode",_get_resolution(Resolution_ob.get_index()))
	SettingsFile.set_value("VIDEO","Graphics",_get_resolution(Resolution_ob.get_index()))
	SettingsFile.set_value("VIDEO","Color blind",_get_resolution(Resolution_ob.get_index()))
	# -- Audio
	SettingsFile.set_value("AUDIO","General",Audio.x)
	SettingsFile.set_value("AUDIO","Music",Audio.y)
	SettingsFile.set_value("AUDIO","SFX",Audio.z)
	
	SettingsFile.save("res://settings.cfg")


func _load_settings():
	if (SettingsFile.load("res://settings.cfg") != OK):
		_first_time()
	else:
		pass
func _save_settings() -> void:
	# -- Video
	SettingsFile.set_value("VIDEO","Resolution",_get_resolution(Resolution_ob.get_index()))
	SettingsFile.set_value("VIDEO","Vsync",Vsync)
	SettingsFile.set_value("VIDEO","Window Mode",_get_resolution(Resolution_ob.get_index()))
	SettingsFile.set_value("VIDEO","Graphics",_get_resolution(Resolution_ob.get_index()))
	SettingsFile.set_value("VIDEO","Color blind",_get_resolution(Resolution_ob.get_index()))
	# -- Audio
	SettingsFile.set_value("AUDIO","General",Audio.x)
	SettingsFile.set_value("AUDIO","Music",Audio.y)
	SettingsFile.set_value("AUDIO","SFX",Audio.z)
	
	SettingsFile.save("res://settings.cfg")



func _ready():
	_load_settings()
	Resolution_ob.select(_check_resolution(DisplayServer.screen_get_size()))
	
	MainContainer.set_pivot_offset(MainContainer.size/2)
	for child in MainContainer.get_children():
		child.set_pivot_offset(child.size/2)
		child.connect("mouse_entered", _on_mouse_entered.bind(child.get_index()))
		child.connect("mouse_exited", _on_mouse_exited.bind(child.get_index()))


var simultaneous_scene = preload("res://Scenes/hub_world.tscn")

func _on_start_button_pressed():
	# Put your load scene here
	# Check the documentation https://docs.godotengine.org/en/stable/tutorials/scripting/change_scenes_manually.html
	Global.current_scene = "res://Scenes/hub_world.tscn"
	get_tree().change_scene_to_packed(simultaneous_scene)


func _on_mouse_entered(index: int) -> void:
	var button = MainContainer.get_child(index)
	var tween = get_tree().create_tween().bind_node(button)
	tween.tween_property(button, "scale", Vector2(1.1, 1.1), 0.1)


func _on_mouse_exited(index: int) -> void:
	var button = MainContainer.get_child(index)
	var tween = get_tree().create_tween().bind_node(button)
	tween.tween_property(button, "scale", Vector2(1, 1), 0.1)


func _on_option_button_pressed():
	OptionContainer.visible = true
	MainContainer.visible = false


func _on_exit_button_pressed():
	get_tree().quit()


# -- VIDEO TAB --

func _on_resolution_optionbutton_item_selected(index):
	DisplayServer.window_set_size(_get_resolution(index))


func _on_window_mode_optionbutton_item_selected(_index):
	pass # Replace with function body.



func _on_preset_h_slider_value_changed(_value):
	# start here https://docs.godotengine.org/en/stable/tutorials/3d/mesh_lod.html
	pass # Replace with function body.


# -- AUDIO TAB --

func _on_general_h_scroll_bar_value_changed(value):
	Audio.x = value


func _on_music_h_scroll_bar_value_changed(value):
	Audio.y = value


func _on_sfx_h_scroll_bar_value_changed(value):
	Audio.z = value


# -- Save and Exit buttons

func _on_return_button_pressed():
	MainContainer.visible = true
	OptionContainer.visible = false


func _on_apply_button_pressed():
	MainContainer.visible = true
	OptionContainer.visible = false
	_save_settings()



func _on_vsync_option_button_item_selected(index):
	# check the documentation about Vsync : https://docs.godotengine.org/en/stable/classes/class_displayserver.html#enum-displayserver-vsyncmode
	Vsync = index
