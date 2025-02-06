extends Control


@onready var Tree_Root:TextureButton = $ColorRect/SkillButton


func _ready() -> void:
	#grab_focus()
	$ConfirmMenu.visible = false


func _process(_delta: float) -> void:
	$point_count_label.text = str(PlayerStats.upgrade_point)


func _on_reset_button_pressed() -> void:
	$ConfirmMenu.visible = true


func _on_confirm_menu_confirmation_pressed() -> void:
	PlayerStats.upgrade_point = PlayerStats.upgrade_points_spent
	PlayerStats.upgrade_points_spent = 0


func _on_confirm_menu_deny_pressed() -> void:
	$ConfirmMenu.visible = false


func _on_v_scroll_bar_value_changed(value: float) -> void:
	Tree_Root.global_position.y = value
	Tree_Root.redraw_lines()


func _on_h_scroll_bar_value_changed(value: float) -> void:
	Tree_Root.global_position.x = value
	Tree_Root.redraw_lines()
