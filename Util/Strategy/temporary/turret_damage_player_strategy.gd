class_name TurretDamagePlayerStrategy
extends BasePlayerStrategy


@export var increase := 10.0


func apply_upgrade(_player: Player):
	PlayerStats.turret_damage += increase
