extends Node3D


func _on_interactable_component_open_menu() -> void:
	$menu.visible = true


func _on_interactable_component_close_menu() -> void:
	$menu.visible = false
