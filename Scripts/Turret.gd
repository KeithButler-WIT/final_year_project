extends Node3D

@export var rot_speed = 10
@onready var camera : Camera3D = get_node("/root/Level/Player/Camera")

@export var shoot_distance:float = 20
var close_enemy


func _physics_process(delta):
	var all_enemy = get_tree().get_nodes_in_group("enemy")
	for enemy in all_enemy:
		var gun2enemy_distance = position.distance_to(enemy.position)
		if gun2enemy_distance < shoot_distance and gun2enemy_distance > 10:

			shoot_distance = gun2enemy_distance  ## ---> ## with this i storaged the current close enemy to shoot_distance ###	this is need the be reset ever time, shoot distance must be allways 70, so that guns can search enemys that close the guns 70 value. because of that i reset it every 1 second to 70 again.
		  
			close_enemy = enemy  ## --->## after get the current close_enemy

			oto_zone_reset() ##---> call the function that reset the search area again

			look_at(close_enemy.position,Vector3.UP) ## ---> look at the close_enemy
			#print (shoot_distance)
			
	if (close_enemy != null) and position.distance_to(close_enemy.position) < shoot_distance :
		$"Head/Gun".shoot()


func oto_zone_reset():
	await get_tree().create_timer(1)
	shoot_distance = 70
	#print ("shoot distance got reset")
