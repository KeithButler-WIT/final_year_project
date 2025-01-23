extends Node

var Quests: Dictionary = {
	"MQ001": {
		"Name": "",
		"Stage": 0,
		"Description": {
			"01":"Enter the first level."
		}
	},
	"MQ002": {
		"Name": "",
		"Stage": 0,
		"Description": {
			"01":"Beat the first level"
		}
	},
}

var ActiveQuests: Dictionary = {}
var CompletedQuests: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
