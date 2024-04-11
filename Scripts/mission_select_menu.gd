extends Control

@onready var option1 = $"AspectRatioContainer/MainContainer/VContainer/Option"
@onready var option2 = $"AspectRatioContainer/MainContainer/VContainer2/Option"
@onready var option3 = $"AspectRatioContainer/MainContainer/VContainer3/Option"

func _ready():
	visible = false
	option1.text = "Loot"
	option2.text = "Shoot"
	option3.text = "Saving"

func _on_option_1_pressed():
	PlayerStats.current_mission = PlayerStats.MISSION.LOOTING
	visible = false

func _on_option_2_pressed():
	PlayerStats.current_mission = PlayerStats.MISSION.SHOOTING
	visible = false

func _on_option_3_pressed():
	PlayerStats.current_mission = PlayerStats.MISSION.SAVING
	visible = false
