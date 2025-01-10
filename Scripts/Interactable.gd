extends Node3D

var player_in_range = false

@onready var button_icon = $Sprite3D
@onready var menu = $"../mission_select_menu"

func _ready():
	button_icon.visible = false
	menu.visible = false


func _on_area_3d_body_entered(body):
	button_icon.visible = true
	player_in_range = true


func _on_area_3d_body_exited(body):
	button_icon.visible = false
	player_in_range = false

func _process(_delta):
	if Input.is_action_pressed("use_action") and player_in_range:
		menu.visible = true
	if !player_in_range:
		menu.visible = false
