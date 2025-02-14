extends Node3D
class_name BaseLevel


@export var levelLoader : PackedScene
@export var exitLadder : PackedScene
@export var PackedObjective : PackedScene
@export var objectives_needed = 2
var objectives_completed = 0

@onready var exp_bar = $Control/ExpUi/Bar
@onready var exp_label = $Control/ExpUi/Label
@onready var hp_bar = $Control/HpUi/Bar
@onready var hp_label = $Control/HpUi/Label

var time_start = 0


var sec_to_min = func(sec):
	return sec / 60

var msec_to_min = func(msec):
	return msec / 60  / 60 / 60

var time_elapsed = 0.0


func update_exp_bar():
	exp_bar.value = PlayerStats.experience
	exp_bar.max_value = PlayerStats.exp_to_next_level
	exp_label.text = "LEVEL " + str(PlayerStats.level)


func update_hp_bar():
	hp_bar.value = PlayerStats.current_health
	hp_bar.max_value = PlayerStats.max_health
	hp_label.text = str(PlayerStats.current_health) + "/" + str(PlayerStats.max_health)
