extends Node3D

@export var packet_turret: PackedScene
var turrets = []


func place_turret():
	if get_parent().can_place_turret:
		var new_turret = packet_turret.instantiate()
		new_turret.global_transform = global_transform
		var scene_root = get_tree().root  #.get_children()[0]
		scene_root.add_child(new_turret)
		if turrets.size() == PlayerStats.num_turrets_placeable:
			scene_root.remove_child(turrets[0])
			turrets.pop_front()  # remove oldest turret
			turrets.append(new_turret)
			print("Turret Size: ", turrets.size())
			print("Max Turrets reached, replacing oldest one")
		else:
			turrets.append(new_turret)
			print("Spawning turret")
		get_parent().can_place_turret = false
	else:
		print("Turret on cooldown")
