extends Node3D

@export var speed = 70
@export var damage = 1

const KILL_TIME = 2
var timer = 0

func _physics_process(delta):
	var forward_direction = global_transform.basis.z.normalized()
	global_translate(forward_direction * speed * delta)
	
	timer += delta
	if timer >= KILL_TIME:
		queue_free()


func _on_area_3d_body_entered(body: Node):
	# print("get shot ", body)
	queue_free()
	
	if body.has_node("HealthComponent"):
		var health = body.find_child("HealthComponent") as HealthComponent
		health.take_hit(damage)
