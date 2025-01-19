extends Node3D

@export var rot_speed = 10
@onready var camera : Camera3D = get_node("/root/Level/Player/Camera")
@export var range:float = 10

var closest_enemy = null


func _process(_delta):
	var all_enemy = get_tree().get_nodes_in_group("enemy")
	for enemy in all_enemy:
		var enemy_distance = position.distance_to(enemy.position)
		if enemy_distance <= range: # and enemy_distance > 10:
			# range = enemy_distance  ## ---> ## with this i storaged the current close enemy to range ###	this is need the be reset ever time, shoot distance must be allways 70, so that guns can search enemys that close the guns 70 value. because of that i reset it every 1 second to 70 again.
			closest_enemy = enemy  ## --->## after get the current closest_enemy
			oto_zone_reset() ##---> call the function that reset the search area again
			look_at(closest_enemy.position,Vector3.UP) ## ---> look at the close_enemy
			#print (range)

	if (closest_enemy != null) and position.distance_to(closest_enemy.position) < range :
		$"Head/Gun".shoot()


func oto_zone_reset():
	await get_tree().create_timer(1)
	#print ("shoot distance got reset")
