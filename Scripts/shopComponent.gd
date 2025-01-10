extends Node3D

@onready var button_icon = $Sprite3D
@onready var menu = $"shopMenu"

var player_in_range = false

func _ready():
	button_icon.visible = false
	menu.visible = false


func _on_area_3d_body_entered(body):
	button_icon.visible = true
	player_in_range = true


func _on_area_3d_body_exited(_body):
	button_icon.visible = false
	player_in_range = false

func _process(delta):
	if Input.is_action_pressed("use_action") and player_in_range:
		menu.visible = true
	if !player_in_range:
		menu.visible = false
