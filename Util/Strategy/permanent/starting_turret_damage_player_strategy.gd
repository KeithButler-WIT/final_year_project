class_name StartingTurretDamagePlayerStrategy
extends BasePlayerStrategy


@export var increase := 1.0


#func _init() -> void:
	#upgrade_text = "Health"

func apply_upgrade(_player: Player):
	PlayerStats.starting_turret_damage += increase
