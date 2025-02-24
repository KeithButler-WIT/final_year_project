extends Node3D


# Variables used as permanent upgrades
var starting_max_health := PlayerStats.starting_max_health
var starting_num_turrets_placeable := PlayerStats.starting_num_turrets_placeable
var starting_num_weapons := PlayerStats.starting_num_weapons
var starting_turrent_attack_speed := PlayerStats.starting_turrent_attack_speed
var starting_pickup_radius := PlayerStats.starting_pickup_radius
var starting_movement_speed := PlayerStats.starting_movement_speed
var starting_turret_damage := PlayerStats.starting_turret_damage

# Global stats # These get saved
var time_played := PlayerStats.time_played
var total_kills := PlayerStats.total_kills
var total_damage_taken := PlayerStats.total_damage_taken
var total_damage_given := PlayerStats.total_damage_given
var total_health_recovered := PlayerStats.total_health_recovered
var deaths := PlayerStats.deaths
var turrets_placed := PlayerStats.turrets_placed
var highest_level := PlayerStats.highest_level
var total_experience_gained := PlayerStats.total_experience_gained
var missions_completed := PlayerStats.missions_completed
var upgrade_points_spent := PlayerStats.upgrade_points_spent
var upgrade_point := PlayerStats.upgrade_point
var upgrade_choices := PlayerStats.upgrade_choices
var upgrades_picked := PlayerStats.upgrades_picked


func _ready() -> void:
	PlayerStats.starting_max_health = starting_max_health
	PlayerStats.starting_num_turrets_placeable = starting_num_turrets_placeable
	PlayerStats.starting_num_weapons = starting_num_weapons
	PlayerStats.starting_turrent_attack_speed = starting_turrent_attack_speed
	PlayerStats.starting_pickup_radius = starting_pickup_radius
	PlayerStats.starting_movement_speed = starting_movement_speed
	PlayerStats.starting_turret_damage = starting_turret_damage

	PlayerStats.time_played = time_played
	PlayerStats.total_kills = total_kills
	PlayerStats.total_damage_taken = total_damage_taken
	PlayerStats.total_damage_given = total_damage_given
	PlayerStats.total_health_recovered = total_health_recovered
	PlayerStats.deaths = deaths
	PlayerStats.turrets_placed = turrets_placed
	PlayerStats.highest_level = highest_level
	PlayerStats.total_experience_gained = total_experience_gained
	PlayerStats.missions_completed = missions_completed
	PlayerStats.upgrade_points_spent = upgrade_points_spent
	PlayerStats.upgrade_point = upgrade_point
	PlayerStats.upgrade_choices = upgrade_choices
	PlayerStats.upgrades_picked = upgrades_picked

func update_upgrade_stats() -> void:
	starting_max_health = PlayerStats.starting_max_health
	starting_num_turrets_placeable = PlayerStats.starting_num_turrets_placeable
	starting_num_weapons = PlayerStats.starting_num_weapons
	starting_turrent_attack_speed = PlayerStats.starting_turrent_attack_speed
	starting_pickup_radius = PlayerStats.starting_pickup_radius
	starting_movement_speed = PlayerStats.starting_movement_speed
	starting_turret_damage = PlayerStats.starting_turret_damage

func update_gameplay_stats() -> void:
	time_played = PlayerStats.time_played
	total_kills = PlayerStats.total_kills
	total_damage_taken = PlayerStats.total_damage_taken
	total_damage_given = PlayerStats.total_damage_given
	total_health_recovered = PlayerStats.total_health_recovered
	deaths = PlayerStats.deaths
	turrets_placed = PlayerStats.turrets_placed
	highest_level = PlayerStats.highest_level
	total_experience_gained = PlayerStats.total_experience_gained
	missions_completed = PlayerStats.missions_completed
	upgrade_points_spent = PlayerStats.upgrade_points_spent
	upgrade_point = PlayerStats.upgrade_point
	upgrade_choices = PlayerStats.upgrade_choices
	upgrades_picked = PlayerStats.upgrades_picked


# Save data # https://docs.godotengine.org/en/stable/tutorials/io/saving_games.html
func save() -> Dictionary:
	update_upgrade_stats()
	update_gameplay_stats()
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"pos_z" : position.z,
		"time_played" : time_played,
		"total_kills" : total_kills,
		"total_damage_taken" : total_damage_taken,
		"total_damage_given" : total_damage_given,
		"total_health_recovered" : total_health_recovered,
		"deaths" : deaths,
		"turrets_placed" : turrets_placed,
		"highest_level" : highest_level,
		"total_experience_gained" : total_experience_gained,
		"missions_completed" : missions_completed,
		"upgrade_points_spent" : upgrade_points_spent,
		"upgrade_point" : upgrade_point,
		"upgrade_choices" : upgrade_choices,
		"upgrades_picked" : upgrades_picked,
		
		"starting_max_health" : starting_max_health,
		"starting_num_turrets_placeable" : starting_num_turrets_placeable,
		"starting_num_weapons" : starting_num_weapons,
		"starting_turrent_attack_speed" : starting_turrent_attack_speed,
		"starting_pickup_radius" : starting_pickup_radius,
		"starting_movement_speed" : starting_movement_speed,
		"starting_turret_damage" : starting_turret_damage
	}
	return save_dict
