extends Control

@export var Confirmation_Text:String = "Do you confirm y/n"

signal confirmation_pressed
signal deny_pressed


func _ready() -> void:
	grab_focus()

func _on_confirm_button_pressed() -> void:
	confirmation_pressed.emit()


func _on_deny_button_pressed() -> void:
	deny_pressed.emit()
