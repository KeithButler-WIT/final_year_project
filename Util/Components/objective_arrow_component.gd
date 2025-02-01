extends Node3D


func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $"../..".has_node("Objective"):
		visible = true
		look_at($"../../Objective".position)
	elif $"../..".has_node("level_loader"):
		visible = true
		look_at($"../../level_loader".position)
	else:
		visible = false
