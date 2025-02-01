extends Node3D

@export var packet_turret: PackedScene
var turrets = []


func _animate_turret_placing(turret: Node3D):
	var tween = get_tree().create_tween().bind_node(turret)
	#tween.set_parallel(true)
	tween.tween_property(turret, "scale", Vector3(0,0,0), 0.0001)
	tween.tween_property(turret, "scale", Vector3(1,1,1), 0.4)


func place_turret():
	if get_parent().can_place_turret:
		var new_turret = packet_turret.instantiate()
		new_turret.global_transform = global_transform
		#var scene_root = get_tree().root  #.get_children()[0]
		#scene_root.add_child(new_turret)
		get_tree().current_scene.add_child(new_turret)
		_animate_turret_placing(new_turret)
		if turrets.size() == PlayerStats.num_turrets_placeable:
			get_tree().current_scene.remove_child(turrets[0])
			turrets.pop_front()  # remove oldest turret
			turrets.append(new_turret)
			if !OS.has_feature("standalone"):
				print("Turret Size: ", turrets.size())
				print("Max Turrets reached, replacing oldest one")
		else:
			turrets.append(new_turret)
			if !OS.has_feature("standalone"):
				print("Spawning turret")
		get_parent().can_place_turret = false
	else:
		if !OS.has_feature("standalone"):
			print("Turret on cooldown")
