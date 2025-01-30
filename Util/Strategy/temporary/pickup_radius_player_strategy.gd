class_name PickupRadiusPlayerStrategy
extends BasePlayerStrategy


@export var increase := 0.2


func _init() -> void:
	upgrade_text = "Pickup Radius"
	description = "Increase %s by %.1f" % [upgrade_text, increase]


func apply_upgrade(_player: Player):
	PlayerStats.pickup_radius += increase
