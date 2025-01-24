class_name StartingTurretAttackSpeedPlayerStrategy
extends BasePlayerStrategy


@export var increase := 1.0


#func _init() -> void:
	#upgrade_text = "Health"

func apply_upgrade(_player: Player):
	PlayerStats.starting_turrent_attack_speed += increase
