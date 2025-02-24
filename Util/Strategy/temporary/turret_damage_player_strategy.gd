class_name TurretDamagePlayerStrategy
extends BasePlayerStrategy


@export var increase := 10.0

func _init() -> void:
	upgrade_text = "Turret Damage"
	description = "Increase %s by %.1f" % [upgrade_text, increase]

func apply_upgrade(_player: Player):
	PlayerStats.turret_damage += increase
