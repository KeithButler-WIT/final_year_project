class_name SpeedPlayerStrategy
extends BasePlayerStrategy


@export var increase := 10.0


func apply_upgrade(_player: Player):
	PlayerStats.movement_speed += increase
