extends CharacterBody3D

class_name Enemy


@export var movement_speed: float = 2.0
var movement_target_position: Vector3 = Vector3(-3.0,0.0,2.0)
@export var attack_speed_multiplier :float = 5.0

#@export var player : CharacterBody3D
@onready var player: CharacterBody3D = $"../Player"
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
#@onready var attack_timer = $AttackTimer
@onready var animationPlayer : AnimationPlayer = $Character/AnimationPlayer

var attack_target: Vector3
var return_target: Vector3

enum state {
	SEEKING,
	ATTACKING,
	RETURNING,
	RESTING,
}

var current_state := state.SEEKING

@export var damage:float = 1.0;


func _ready() -> void:
	damage = damage * (1+(PlayerStats.player_skill/100))
	movement_speed = movement_speed * (1+(PlayerStats.player_skill/100))

func _on_health_died_signal() -> void:
	if get_node_or_null("DropXPComponent"):
		$DropXPComponent.spawn()
	if get_node_or_null("DropUpgradePointComponent"):
		$DropUpgradePointComponent.spawn()
	var tween := get_tree().create_tween().bind_node(self)
	#tween.set_parallel(true)
	tween.tween_property($Character, "modulate", Color.RED, 0.2)
	tween.tween_property($Character, "scale", Vector3(1,0,1), 0.2)
	if (tween.finished):
		tween.tween_callback(self.queue_free)


func change_screen_edge() -> Vector3:
	if navigation_agent.target_position:
		var distance := global_position.distance_to(navigation_agent.target_position)
		var direction := global_position.direction_to(navigation_agent.target_position)
		# TODO: refine values
		if distance > 40 and distance < 200:
			#print("Direction: ", direction)
			#print("Distance: ", distance)
			#print("Moving to other side of screen")
			#print("Position Before: ", global_position)
			#print(direction.ceil().x * (distance*2))
			#position *= direction.ceil() * (distance*2)
			global_position.x += direction.round().x * ((distance-2)*2)
			global_position.z += direction.round().z * ((distance-2)*2)
			#print("Position After: ", global_position)
	return global_position
