extends Node

@export var StartingWeapon : PackedScene
var hand : Marker3D
var equipped_weapon : Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	hand = get_parent().find_child("Hand")
	if StartingWeapon:
		equip_weapon(StartingWeapon)

func equip_weapon(weapon_to_equip):
	if equipped_weapon:
		print("Deleting current weapon")
		equipped_weapon.queue_free()
	else:
		print("No weapon equip")
		equipped_weapon = weapon_to_equip.instantiate()
		hand.add_child(equipped_weapon)

func shoot():
	if equipped_weapon:
		# Play particle effect
		equipped_weapon.shoot()
