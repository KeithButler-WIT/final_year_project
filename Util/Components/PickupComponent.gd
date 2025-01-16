extends Node3D


func _on_pickup_area_body_entered(body: Node3D):
	var exp = body.get_parent_node_3d()
	#print("Exp detected:", exp.name)
	increase_stats()
	animate_pickup(exp)
	#cleanup(exp)

func animate_pickup(body:Node3D): # TODO: Fix tween animation
	var tween = get_tree().create_tween()#.bind_node(body).set_trans(Tween.TRANS_ELASTIC)
	tween.set_parallel(true)
	tween.tween_property(body, "position", global_position, 1)
	if (tween.finished):
		tween.tween_callback(body.queue_free)

func increase_stats():
	PlayerStats.experience += 1
	PlayerStats.total_experience_gained += 1

func cleanup(body:Node3D):
	body.queue_free()
