class_name SpeedPlayerStrategy
extends BasePlayerStrategy


@export var speed_increase := 50.0


func apply_upgrade(player: Player):
	PlayerStats.movement_speed += speed_increase
