extends Control

@onready var option1 = $"AspectRatioContainer/MainContainer/VContainer/Option"
@onready var option2 = $"AspectRatioContainer/MainContainer/VContainer2/Option"
@onready var option3 = $"AspectRatioContainer/MainContainer/VContainer3/Option"
@onready var gate = $"../../gate"

func _ready():
	visible = false
	option1.text = "Loot"
	option2.text = "Shoot"
	option3.text = "Saving"

func _on_option_1_pressed():
	_remove_gate()
	PlayerStats.current_mission = PlayerStats.MISSION.LOOTING
	visible = false

func _on_option_2_pressed():
	_remove_gate()
	PlayerStats.current_mission = PlayerStats.MISSION.SHOOTING
	visible = false

func _on_option_3_pressed():
	_remove_gate()
	PlayerStats.current_mission = PlayerStats.MISSION.SAVING
	visible = false

func _remove_gate():
	if get_node_or_null("../../gate") != null:
		gate.queue_free()
