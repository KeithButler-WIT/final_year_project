extends Enemy


func _ready() -> void:
	damage = damage * (1+(PlayerStats.player_skill/100))
	movement_speed = movement_speed * (1+(PlayerStats.player_skill/100))

	animationPlayer.play("idle")
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 0.5
	navigation_agent.target_desired_distance = 0.5

	# Make sure to not await during _ready.
	call_deferred("actor_setup")


func _process(delta: float) -> void:
	change_screen_edge()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _physics_process(_delta):
	if is_instance_valid(player):
		match current_state:
			state.SEEKING:
				if navigation_agent.is_navigation_finished():
					animationPlayer.play("idle")
					current_state = state.ATTACKING
					return

				var current_agent_position: Vector3 = global_position
				var next_path_position: Vector3 = navigation_agent.get_next_path_position()

				velocity = current_agent_position.direction_to(next_path_position) * movement_speed
				animationPlayer.play("walk_down")
				move_and_slide()
			state.ATTACKING:
				move_and_attack()
			state.RETURNING:
				print("RETURNING")
			state.RESTING:
				print("RESTING")
				animationPlayer.play("idle")


func move_and_attack():
	var attack_position: Vector3 = navigation_agent.get_final_position()
	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	animationPlayer.play("walk_down")
	move_and_slide()
	
	if global_transform.origin.distance_to(attack_position) < 1:
		match current_state:
			state.ATTACKING:
				# Do damage to the player
				player.take_hit(damage)
				current_state == state.SEEKING
				#attack_target = current_agent_position
			state.RETURNING:
				current_state == state.RESTING
				#attack_timer.start()


func _on_PathUpdateTimer_timeout():
	if is_instance_valid(player):
		# Now that the navigation map is no longer empty, set the movement target.
		set_movement_target(player.global_transform.origin)


func _on_AttackRadius_body_entered(body):
	if body == player:
		attack_target = player.global_transform.origin
		current_state = state.ATTACKING
		return_target = global_transform.origin
		#print("Player in range:  ", body)


func _on_attack_timer_timeout():
	current_state = state.SEEKING
