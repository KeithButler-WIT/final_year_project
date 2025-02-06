class_name StartingUpgradeChoicePlayerStrategy
extends BasePlayerStrategy


@export var increase := 1


func _init() -> void:
	upgrade_text = "Upgrade Choices"
	description = "Increase %s by %d" % [upgrade_text, increase]


func apply_upgrade(_player: Player):
	PlayerStats.upgrade_choices += increase
