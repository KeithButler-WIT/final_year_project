@tool
extends TextureButton
class_name SkillNode


@onready var skillLevel = $SkillLevel
@onready var skillBranch = $SkillBranch
@export var maxLevel:int = 3
@export var upgrade:BasePlayerStrategy

var level:int = 0:
	set(value):
		level = value
		skillLevel.text = str(level) + "/" + str(maxLevel)


func _ready() -> void:
	grab_focus()
	_update_label()
	_connect_nodes()

func _update_label() -> void:
	if maxLevel == 1:
		skillLevel.text = ""
		skillLevel.visible = false
	else:
		skillLevel.text = str(level) + "/" + str(maxLevel)

func _connect_nodes() -> void:
	if get_parent() is SkillNode:
		skillBranch.add_point(global_position + size/2)
		skillBranch.add_point(get_parent().global_position + get_parent().size/2)
		#skillBranch.add_point(global_position + size/2)
		#skillBranch.add_point(get_parent().global_position + get_parent().size/2)


func _process(_delta):
	if Engine.is_editor_hint():
		_update_label()
		redraw_lines()

	if not Engine.is_editor_hint():
		pass


func redraw_lines():
	skillBranch.clear_points()
	_connect_nodes()


func _on_pressed() -> void:
	activate_button()


func activate_button():
	if !PlayerStats.upgrade_point:
		print("No upgrade points")
		# TODO: play sound
		return


	if level < maxLevel:
		update_upgrade_points()
		upgrade.apply_upgrade(%Player)

	level = min(level+1, maxLevel)
	# TODO: play sound
	lighten_color()
	skillBranch.default_color = Color(1, 1, 1)
	enable_children()


func enable_children():
	for child in get_children():
		if child is SkillNode and level == 1:
			child.disabled = false


func lighten_color():
	self_modulate = Color(1, 1, 1)


func update_upgrade_points():
	PlayerStats.upgrade_point -= 1
	PlayerStats.upgrade_points_spent += 1
