extends CharacterBody3D

class_name Enemy

var movement_speed: float = 2.0
var movement_target_position: Vector3 = Vector3(-3.0,0.0,2.0)
var attack_speed_multiplier = 5

#@export var player : CharacterBody3D
@onready var player: CharacterBody3D = $"../Player"
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var attack_timer = $AttackTimer

var attack_target: Vector3
var return_target: Vector3

enum state {
	SEEKING,
	ATTACKING,
	RETURNING,
	RESTING,
}

var current_state = state.SEEKING

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	match current_state:
		state.SEEKING:
			if navigation_agent.is_navigation_finished():
				return

			var current_agent_position: Vector3 = global_position
			var next_path_position: Vector3 = navigation_agent.get_next_path_position()

			velocity = current_agent_position.direction_to(next_path_position) * movement_speed
			move_and_slide()
		state.ATTACKING:
			move_and_attack()
		state.RETURNING:
			print("RETURNING")
		state.RESTING:
			print("RESTING")


func move_and_attack():
	var current_agent_position: Vector3 = global_transform.origin
	var attack_position: Vector3 = navigation_agent.get_final_position()

	velocity = current_agent_position.direction_to(attack_position) * movement_speed  * attack_speed_multiplier
	move_and_slide()
	
	if global_transform.origin.distance_to(attack_position) < 1:
		match current_state:
			state.ATTACKING:
				current_state == state.RETURNING
				attack_target = current_agent_position
			state.RETURNING:
				current_state == state.RESTING
				attack_timer.start()


func _on_PathUpdateTimer_timeout():
	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(player.global_transform.origin)


func _on_health_died_signal():
	queue_free()


func _on_AttackRadius_body_entered(body):
	if body == player:
		attack_target = player.global_transform.origin
		current_state = state.ATTACKING
		return_target = global_transform.origin
		print("Player in range:  ", body)


func _on_attack_timer_timeout():
	current_state = state.SEEKING
