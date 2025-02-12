@tool
extends Node3D


@export var scene: PackedScene
@export var cell_size :Vector3 = Vector3.ZERO
@export var chunk_size :Vector3 = Vector3.ZERO
@export var loading_radius :Vector3 = Vector3.ZERO

@onready var player = %Player

var center = 0
var gridmap = []

func _ready() -> void:
	center = round((float(chunk_size.x * chunk_size.z))/2)
	print("Center: ", center)
	print("Generating Map")
	for row in chunk_size.x:
		for col in chunk_size.z:
			var cell = scene.instantiate()
			cell.global_position = Vector3(player.global_position.x+(cell_size.x*row),0,player.global_position.z+(cell_size.z*col))
			print("Cell: ", cell.global_position)
			add_child(cell)
			gridmap.append(cell)
			#get_tree().current_scene.add_child(cell)


#func _process(delta: float) -> void:
	#if player.global_position.x > cell_size.x:
		#var cell = scene.instantiate()
		##cell.global_transform = Vector3()
		#cell.global_position.x = player.global_position.x
		#cell.global_position.y = 0
		#cell.global_position.z = player.global_position.z
		#print("Cell: ", cell.global_position)

#func _process(delta: float) -> void:
	#print("Generating Map")
	#for row in chunk_size.x:
		#for col in chunk_size.z:
			#var cell = scene.instantiate()
			#cell.global_position = Vector3(player.global_position.x+(cell_size.x*row),0,player.global_position.z+(cell_size.z*col))
			#print("Cell: ", cell.global_position)
			#add_child(cell)
