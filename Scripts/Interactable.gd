extends Node3D

var player_in_range = false

func _ready():
	$Sprite3D.visible = false
	$"../mission_select_menu".visible = false


func _on_area_3d_body_entered(body):
	$Sprite3D.visible = true
	player_in_range = true


func _on_area_3d_body_exited(body):
	$Sprite3D.visible = false
	player_in_range = false


func _process(delta):
	if Input.is_action_pressed("use_action") and player_in_range:
		$"../mission_select_menu".visible = true
	if !player_in_range:
		$"../mission_select_menu".visible = false
