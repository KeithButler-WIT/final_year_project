extends Control


@onready var Tree_Root:TextureButton = $ColorRect/SkillButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ConfirmMenu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Tree_Root.position.y = $ColorRect/VScrollBar.value
	Tree_Root.position.x = $ColorRect/HScrollBar.value
	Tree_Root.redraw_lines()


func _on_reset_button_pressed() -> void:
	#TODO: implement on reset_pressed
	#TODO: open a confirm window
	$ConfirmMenu.visible = true


func _on_confirm_menu_confirmation_pressed() -> void:
	#TODO: RESET UPGRADE POINTS
	print("TODO: RESET UPGRADE POINTS")


func _on_confirm_menu_deny_pressed() -> void:
	$ConfirmMenu.visible = false
