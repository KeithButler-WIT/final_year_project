extends Control


@onready var main_container = $MainContainer
@onready var upgrades = []
@onready var upgrade
@onready var upgrade_list = []


func _ready():
	upgrades = Utils.get_all_files("res://Util/Strategy/temporary")
	visible = false

func _process(delta: float) -> void:
	if !OS.has_feature("standalone"):
		if Input.is_key_pressed(KEY_L):
			visible = !visible
		if Input.is_key_pressed(KEY_BRACKETLEFT):
			PlayerStats.upgrade_choices -= 1 if PlayerStats.upgrade_choices > 0 else PlayerStats.upgrade_choices
			print(PlayerStats.upgrade_choices)
		if Input.is_key_pressed(KEY_BRACKETRIGHT):
			PlayerStats.upgrade_choices += 1 if PlayerStats.upgrade_choices < 8 else PlayerStats.upgrade_choices
			print(PlayerStats.upgrade_choices)



func get_random_upgrade() -> Resource:
	# randomily pick one
	# return and spawn in scene on player
	randomize()
	if upgrades:
		upgrades.shuffle()
		return load(upgrades[0]).new()
	return null

@export var packedVContainer : PackedScene

func _on_visibility_changed() -> void:
	if upgrades:
		if visible:
			for i in PlayerStats.upgrade_choices:
				var vcontainer = packedVContainer.instantiate()
				main_container.add_child(vcontainer)
				main_container.set_pivot_offset(main_container.size/2)
				upgrade = get_random_upgrade()
				upgrade_list.append(upgrade)
				var button = main_container.get_child(i).get_child(-1)
				button.text = upgrade.description
				button.set_pivot_offset(button.size/2)
				button.connect("pressed", _on_option_pressed.bind(i))
				button.connect("mouse_entered", _on_option_mouse_entered.bind(i))
				button.connect("mouse_exited", _on_option_mouse_exited.bind(i))
		else:
			for child in main_container.get_children():
				child.disconnect("pressed", _on_option_pressed)
				child.disconnect("mouse_entered", _on_option_mouse_entered)
				child.disconnect("mouse_exited", _on_option_mouse_exited)
				child.queue_free()


func base_stat_increase():
	#PlayerStats.level += 1 # Handled in different script
	PlayerStats.max_health += 10
	PlayerStats.current_health += 10


func _on_option_pressed(index: int):
	base_stat_increase()
	upgrade_list[index].apply_upgrade(%Player)
	visible = false


func _on_option_mouse_entered(index: int) -> void:
	#tween.set_parallel(true)
	var button = main_container.get_child(index).get_child(-1)
	animate_rotation(button, 1 , 0.1)


func animate_rotation(node:Control, degrees: int, time:float):
	var tween = get_tree().create_tween().bind_node(node)
	# tween.set_loops(0)
	tween.tween_property(node, "scale", 2.2, time)
	tween.tween_property(node, "rotation_degrees", 0, time)
	tween.tween_property(node, "rotation_degrees", degrees, time)
	tween.tween_property(node, "rotation_degrees", 0, time)
	tween.tween_property(node, "rotation_degrees", -degrees, time)
	tween.tween_property(node, "rotation_degrees", 0, time)


func _on_option_mouse_exited(index: int) -> void:
	var button = main_container.get_child(index).get_child(-1)
	# if get_tree().has_node("tween"):
	# 	get_tree().get_node("tween").kill()
	var tween = get_tree().create_tween().bind_node(button)
	tween.set_parallel(true)
	tween.tween_property(button, "rotation_degrees", 0, 1)
	tween.tween_property(button, "scale", 1, 0.1)
