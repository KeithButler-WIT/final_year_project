extends Node


@export var exp_packed : PackedScene
@export var num_exp_to_drop = 1
func spawn():
	for i in range(0,num_exp_to_drop):
		var exp = exp_packed.instantiate()
		exp.global_transform = get_parent().global_transform
		get_tree().current_scene.add_child(exp)
