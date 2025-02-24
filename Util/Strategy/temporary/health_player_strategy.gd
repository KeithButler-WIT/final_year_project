class_name HealthPlayerStrategy
extends BasePlayerStrategy


@export var increase := 50.0


func _init() -> void:
	upgrade_text = "Health"
	description = "Increase %s by %.1f" % [upgrade_text, increase]

func apply_upgrade(_player: Player):
	PlayerStats.max_health += increase
	PlayerStats.current_health = clamp(PlayerStats.current_health+increase, 0, PlayerStats.max_health)
