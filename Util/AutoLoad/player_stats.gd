extends Node

# Variables used as permanent upgrades
var starting_max_health = 10
var starting_num_turrets_placeable = 1
var starting_num_weapons = 1
var starting_turrent_attack_speed = 1
var starting_pickup_radius = 1
var starting_movement_speed = 5
var starting_turret_damage = 1

# Player stats # These reset every mission
var max_health = starting_max_health
var current_health = max_health
var num_turrets_placeable = starting_num_turrets_placeable
var num_weapons = starting_num_weapons
var turret_attack_speed = starting_turrent_attack_speed
var pickup_radius = starting_pickup_radius
var level = 1
var experience = 0
var exp_to_next_level = 10
var movement_speed = starting_movement_speed
var turret_damage = starting_turret_damage
var player_skill = 5


# Global stats # These get saved
var time_played = 0
var total_kills = 0
var total_damage_taken = 0
var total_damage_given = 0
var total_health_recovered = 0
var deaths = 0
var turrets_placed = 0
var highest_level = 0
var total_experience_gained = 0
var missions_completed = 0
var upgrade_point = 0

enum MISSION {
	LOOTING,
	SHOOTING,
	SAVING,
	SURVIVE,
	NONE,
}

var current_mission = MISSION.NONE

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# get signal from level complete to know when to save data
	pass

func decrease_skill(skill):
	if player_skill < skill:
		player_skill = 1
	else:
		player_skill -= skill

func increase_skill(skill):
	player_skill += skill

func set_skill(skill):
	if player_skill <= 0:
		player_skill = 1
	else:
		player_skill = skill

func reset():
	### Resets the player stats after dying ###
	max_health = starting_max_health
	current_health = max_health
	num_turrets_placeable = starting_num_turrets_placeable
	num_weapons = starting_num_weapons
	turret_attack_speed = starting_turrent_attack_speed
	pickup_radius = starting_pickup_radius
	level = 1
	experience = 0
	exp_to_next_level = 10
	movement_speed = starting_movement_speed
	turret_damage = starting_turret_damage
	player_skill = 5


# Save data
func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"time_played" : time_played,
		"total_kills" : total_kills,
		"total_damage_taken" : total_damage_taken,
		"total_damage_given" : total_damage_given,
		"total_health_recovered" : total_health_recovered,
		"deaths" : deaths,
		"turrets_placed" : turrets_placed,
		"highest_level" : highest_level,
		"total_experience_gained": total_experience_gained,
		"missions_completed": missions_completed,
		"upgrade_point" : upgrade_point
	}
	return save_dict

# Note: This can be called from anywhere inside the tree. This function is
# path independent.
# Go through everything in the persist category and ask them to return a
# dict of relevant variables.
func save_game():
	var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data = node.call("save")

		# JSON provides a static method to serialized JSON string.
		var json_string = JSON.stringify(node_data)

		# Store the save dictionary as a new line in the save file.
		save_game.store_line(json_string)


# Load data
# Note: This can be called from anywhere inside the tree. This function
# is path independent.
func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# We need to revert the game state so we're not cloning objects
	# during loading. This will vary wildly depending on the needs of a
	# project, so take care with this step.
	# For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var node_data = json.get_data()

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		#new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
		#new_object.time_played = node_data["time_played"];
		#new_object.total_kills = node_data["total_kills"];
		#new_object.total_damage_taken = node_data["total_damage_taken"];
		#new_object.total_damage_given = node_data["total_damage_given"];
		#new_object.total_health_recovered = node_data["total_health_recovered"];
		#new_object.deaths = node_data["deaths"];
		#new_object.turrets_placed = node_data["turrets_placed"];

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent": # or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
