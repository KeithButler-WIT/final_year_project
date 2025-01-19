class_name HealthPlayerStrategy
extends BasePlayerStrategy


@export var increase := 50.0


#func _init() -> void:
	#upgrade_text = "Health"

func apply_upgrade(_player: Player):
	PlayerStats.max_health += increase
