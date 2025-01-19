extends Node

@onready var button_icon = $Sprite3D

signal OpenMenu
signal CloseMenu

var player_in_range = false

func _ready():
	button_icon.visible = false
	player_in_range = false


func _on_area_3d_body_entered(body):
	print("entered")
	if body.is_in_group("player"):
		button_icon.visible = true
		player_in_range = true


func _on_area_3d_body_exited(body):
	print("Left")
	if body.is_in_group("player"):
		button_icon.visible = false
		player_in_range = false


func _process(_delta):
	print(player_in_range)
	if Input.is_action_pressed("use_action") and player_in_range: # TODO: FIX not dececting player
		print("INPUT PRESSED")
		print("sending open signal")
		OpenMenu.emit()
	if !player_in_range and $"../menu".visible:
		print("sending close signal")
		CloseMenu.emit()
