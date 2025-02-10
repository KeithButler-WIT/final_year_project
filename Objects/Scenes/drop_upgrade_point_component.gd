extends Node


@export var sprite_packed : PackedScene
@export var num_to_drop = 1
func spawn():
	for i in range(0,num_to_drop):
		var sprite = sprite_packed.instantiate()
		sprite.global_transform = get_parent().global_transform
		get_tree().current_scene.add_child(sprite)
