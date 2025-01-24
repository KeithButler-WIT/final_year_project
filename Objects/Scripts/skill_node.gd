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
	_connect_nodes()


func _connect_nodes() -> void:
	skillLevel.text = str(level) + "/" + str(maxLevel)
	if get_parent() is SkillNode:
		skillBranch.add_point(global_position + size/2)
		skillBranch.add_point(get_parent().global_position + get_parent().size/2)


func _process(_delta):
	if Engine.is_editor_hint():
		redraw_lines()

	if not Engine.is_editor_hint():
		pass


func redraw_lines():
	skillBranch.clear_points()
	_connect_nodes()


func _on_pressed() -> void:
	# TODO: subtract upgrade point
	level = min(level+1, maxLevel)
	self_modulate = Color(1, 1, 1)
	
	if level+1 <= maxLevel:
		update_upgrade_points()
	
	skillBranch.default_color = Color(1,1,1)
	
	var skills = get_children()
	for skill in skills:
		if skill is SkillNode and level == 1:
			skill.disabled = false


func update_upgrade_points():
	#TODO: Stop going past 0
	PlayerStats.upgrade_point -= 1
	PlayerStats.upgrade_points_spent += 1
