extends Node



@export var exp_packed : PackedScene
@export var num_exp_to_drop = 1
func spawn_exp():
	for i in range(0,num_exp_to_drop):
		var exp = exp_packed.instantiate()
		exp.global_transform = get_parent().global_transform
		#var scene_root = get_tree().root#.get_children()[0]
		#scene_root.add_child(exp)
		get_tree().current_scene.add_child(exp)
