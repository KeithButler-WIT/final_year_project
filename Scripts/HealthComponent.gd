extends Node

class_name HealthComponent

@export var max_health = 10
var current_health = max_health

signal died_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func take_hit(damage):
	current_health -= damage
	#print($"..".name, " got hit ", current_health, "/", max_health)
	
	if current_health <= 0:
		die()

func die():
	emit_signal("died_signal")
