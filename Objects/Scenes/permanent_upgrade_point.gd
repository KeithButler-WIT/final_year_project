extends Node3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Tween rotation?
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		# TODO: Play sound
		PlayerStats.upgrade_point += 1
		queue_free()
