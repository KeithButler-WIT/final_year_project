class_name PickupRadiusPlayerStrategy
extends BasePlayerStrategy


@export var increase := 0.2


func _init() -> void:
	upgrade_text = "Pickup Radius"
	description = "Increase pickup radius by %f" % increase
	#description = description % increase
	#description = "Increase %s by %f" % upgrade_text % increase

func apply_upgrade(_player: Player):
	PlayerStats.pickup_radius += increase
