class_name SpeedPlayerStrategy
extends BasePlayerStrategy


@export var increase := 1.0

func _init() -> void:
	upgrade_text = "Speed"
	description = "Increase %s by %.1f" % [upgrade_text, increase]

func apply_upgrade(_player: Player):
	PlayerStats.movement_speed += increase
