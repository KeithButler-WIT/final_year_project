class_name Player
extends CharacterBody3D

const LEVEL_SCENE_PATH: String = "res://levels/hub_world.tscn"

@onready var gun_controller = $GunController

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var can_place_turret: bool = true
var canBeDamaged: bool = true

############################################
# Strategy Relevant Code:
# This is where the upgrades are stored
############################################
var upgrades: Array[BasePlayerStrategy] = []
# these don't get removed on death
var permanent_upgrades: Array[BasePlayerStrategy] = []


func _ready():
	pass


func _process(_delta):
	shoot()


func _physics_process(_delta):
	# TODO: run every 0.5 seconds
	pass


func shoot():
	# Shooting
	if Input.is_action_pressed("primary_action"):
		gun_controller.shoot()
	if Input.is_action_pressed("turret_place"):
		$TurretPlacingComponent.place_turret()


func take_hit(damage):
	# TODO: Add cooldown to being hit
	if canBeDamaged:
		PlayerStats.current_health -= damage
		canBeDamaged = false
		print("HP: ", PlayerStats.current_health, "/", PlayerStats.max_health)
		PlayerStats.decrease_skill(1)

	if PlayerStats.current_health <= 0:
		die()


func die():
	print("GAME OVER")
	upgrades.clear()
	#TODO: play death animations
	#TODO: Show game over animations
	#TODO: wait
	ResourceLoader.load_threaded_request(LEVEL_SCENE_PATH)
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(LEVEL_SCENE_PATH))
	#emit_signal("player_died_signal")
	#visible = false
	#queue_free()
	#Global.goto_scene("res://levels/hub_world.tscn")


func _on_turret_place_timer_timeout():
	can_place_turret = true


func _on_can_be_damaged_timer_timeout():
	canBeDamaged = true
