extends Node3D

func _process(delta: float) -> void:
	#$"../pickup_area".scale.x = PlayerStats.pickup_radius
	#$"../pickup_area".scale.z = PlayerStats.pickup_radius
	$"../pickup_area/CollisionShape3D".scale.x = PlayerStats.pickup_radius
	$"../pickup_area/CollisionShape3D".scale.z = PlayerStats.pickup_radius


func _on_pickup_area_body_entered(body: Node3D):
	var exp = body.get_parent_node_3d()
	#print("Exp detected:", exp.name)
	increase_stats()
	animate_pickup(exp)
	#animate_player()
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(%Player/Character, "scale", Vector3(1.1,1.1,1.1), 0.2)
	tween.tween_property(%Player/Character, "scale", Vector3(1,1,1), 0.2)
	#cleanup(exp)

func animate_pickup(body:Node3D): # TODO: Fix tween animation
	body.get_node("RigidBody3D").get_node("CollisionShape3D").disabled = true
	var tween = get_tree().create_tween().bind_node(self)
	tween.set_parallel(true)
	tween.tween_property(body, "position", global_position, 0.1)
	if (tween.finished):
		tween.tween_callback(body.queue_free)

func increase_stats():
	PlayerStats.experience += 1
	PlayerStats.total_experience_gained += 1

func cleanup(body:Node3D):
	body.queue_free()
