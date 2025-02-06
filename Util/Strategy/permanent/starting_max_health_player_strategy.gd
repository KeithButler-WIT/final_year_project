class_name StartingMaxHealthPlayerStrategy
extends BasePlayerStrategy


@export var increase := 10.0


func _init() -> void:
	upgrade_text = "Health"

func apply_upgrade(_player: Player):
	PlayerStats.starting_max_health += increase
