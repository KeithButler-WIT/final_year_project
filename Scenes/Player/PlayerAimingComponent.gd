extends Node3D


var ray_origin = Vector3()
var ray_target = Vector3()

@onready var player = $"../Player"
@onready var camera = $"../Player/Camera"
@onready var player_body = $"../Player/Body"

func _physics_process(_delta):
	if is_instance_valid(player):
		var mouse_position = get_viewport().get_mouse_position()
		#print("Mouse Position: ", mouse_position)
		
		ray_origin = camera.project_ray_origin(mouse_position)
		#print("ray_origin: ", ray_origin)
		ray_target = ray_origin + camera.project_ray_normal(mouse_position) * 2000
		
		var space_state = get_world_3d().direct_space_state
		var intersection = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(ray_origin, ray_target))
		
		if not intersection.is_empty():
			var pos = intersection.position
			var look_at_me = Vector3(pos.x, 0, pos.z) # player still looks down a bit
			player_body.look_at(look_at_me, Vector3.UP)
