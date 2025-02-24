extends Control


@onready var Tree_Root:TextureButton = $ColorRect/SkillButton
@onready var upgrade_nodes = get_tree().get_nodes_in_group("UpgradeButton")
@onready var point_count_label = $HSplitContainer/point_count_label

func _ready() -> void:
	#grab_focus()
	$ConfirmMenu.visible = false


func _process(_delta: float) -> void:
	point_count_label.text = str(PlayerStats.upgrade_point)


func _on_reset_button_pressed() -> void:
	$ConfirmMenu.visible = true


func _on_confirm_menu_confirmation_pressed() -> void:
	PlayerStats.upgrade_point = PlayerStats.upgrade_points_spent
	PlayerStats.upgrade_points_spent = 0


func update_upgrades_picked():
	var upgrade_levels = func(nodes: Array[Node]):
		var temp = []
		for n in nodes:
			temp.append(n.level)
		return temp
	
	upgrade_nodes = get_tree().get_nodes_in_group("UpgradeButton")
	if PlayerStats.upgrades_picked.is_empty():
		PlayerStats.upgrades_picked = upgrade_levels.call(upgrade_nodes)
	print("Inside of update upgrades picked: ", PlayerStats.upgrades_picked)
	# TODO: new upgrades not being saved
	for i in PlayerStats.upgrades_picked.size():
		#print("upgrades_picked : level : ", PlayerStats.upgrades_picked[i])
		#print("upgrade_nodes : level : ", upgrade_nodes[i].level)
		if upgrade_nodes[i].level != PlayerStats.upgrades_picked[i]:
			upgrade_nodes[i].level += PlayerStats.upgrades_picked[i]
		if PlayerStats.upgrades_picked[i]:
			upgrade_nodes[i].lighten_color()
			upgrade_nodes[i].enable_children()
	PlayerStats.upgrades_picked = upgrade_levels.call(upgrade_nodes)


func _on_confirm_menu_deny_pressed() -> void:
	$ConfirmMenu.visible = false


func _on_v_scroll_bar_value_changed(value: float) -> void:
	Tree_Root.global_position.y = value
	Tree_Root.redraw_lines()


func _on_h_scroll_bar_value_changed(value: float) -> void:
	Tree_Root.global_position.x = value
	Tree_Root.redraw_lines()
