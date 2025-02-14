extends Node

class_name HealthComponent

@export var max_health = 10
var current_health = max_health

signal died_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = max_health * (1+(PlayerStats.player_skill/100))
	current_health = max_health

func take_hit(damage):
	current_health -= damage
	var tween = get_tree().create_tween().bind_node(self)
	#tween.set_parallel(true)
	tween.tween_property($"../Character", "modulate", Color.RED, 0.2)
	tween.tween_property($"../Character", "modulate", Color.WHITE, 0.2)
	#tween.tween_property($"../Character", "scale", Vector3(1,0,1), 0.2)
	#print($"..".name, " got hit ", current_health, "/", max_health)
	
	if current_health <= 0:
		die()

func die():
	died_signal.emit()
