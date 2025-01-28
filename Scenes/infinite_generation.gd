# https://www.youtube.com/watch?v=8GV38uUnzis

extends Node3D

var ground_size = Vector2(100,100)

var next_chunk_coord = Vector3(0,0,0)
@onready var map = $World/Ground
@onready var player = $Player


func _ready() -> void:
	create_chunk(ground_size.x,ground_size.y)

func _physics_process(delta: float) -> void:
	var next_trigger = (next_chunk_coord.z*10) - (ground_size.y*10)
	if player.global_position.z > next_trigger:
		create_chunk(ground_size.x,ground_size.y)

func create_chunk(width, length):
	for x in width:
		for z in length:
			#var a = (randi() % 2)
			map.set_cell_item(Vector3i(x, 0, z + next_chunk_coord.z + 1), 0)
	
	next_chunk_coord.z += length
