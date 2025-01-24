extends Control


@onready var Tree_Root:TextureButton = $ColorRect/SkillButton


func _ready() -> void:
	$ConfirmMenu.visible = false


func _process(_delta: float) -> void:
	Tree_Root.position.y = $ColorRect/VScrollBar.value
	Tree_Root.position.x = $ColorRect/HScrollBar.value
	Tree_Root.redraw_lines()


func _on_reset_button_pressed() -> void:
	$ConfirmMenu.visible = true


func _on_confirm_menu_confirmation_pressed() -> void:
	PlayerStats.upgrade_point = PlayerStats.upgrade_points_spent
	PlayerStats.upgrade_points_spent = 0


func _on_confirm_menu_deny_pressed() -> void:
	$ConfirmMenu.visible = false
