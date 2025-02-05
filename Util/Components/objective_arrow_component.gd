extends Node3D


func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"../..".has_node("Objective"):
		if global_position.distance_to($"../../Objective".global_position) > 3:
			visible = true
			look_at($"../../Objective".position)
		else:
			visible = true
	elif $"../..".has_node("level_loader"):
		if global_position.distance_to($"../../level_loader".global_position) > 3:
			visible = true
			look_at($"../../level_loader".position)
		else:
			visible = true
	else:
		visible = false
