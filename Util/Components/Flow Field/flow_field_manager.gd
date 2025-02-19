class_name FlowFieldManager extends Node

var flow_field := PackedVector3Array()
var costs := PackedInt32Array()

@export var field_size := Vector3(64, 1, 48)
@onready var bounds := Rect2i(Vector2i.ZERO - Vector2i(field_size.x, field_size.z) / 2, Vector2i(field_size.x, field_size.z))

@export var grid_map : GridMap
@export var flow_field_gridmap: GridMap

const GRID_SIZE: int = 16
const MAX_COST: int = 999999

@export var target : Node3D
@export var show_debug_arrows: bool = false:
	set(val):
		show_debug_arrows = val
		if not flow_field_gridmap:
			return
		flow_field_gridmap.visible = show_debug_arrows
		
var target_tile : Vector3i = Vector3i.ZERO
	
var cost_queue: Array[Vector3i] = []
	
const DIRECTIONS = [
	Vector3.FORWARD,
	Vector3.BACK,
	Vector3.LEFT,
	Vector3.RIGHT,
	Vector3.ZERO
]


func _ready() -> void:
	initialize_field()


func _physics_process(delta: float) -> void:
	generate_flow_field()
	#print(flow_field)
	print(costs)


func initialize_field() -> void:
	for x in field_size.x:
		for y in field_size.y:
			costs.append(MAX_COST)
			flow_field.append(Vector3.ZERO)

func index_to_cell(index:int) -> Vector3i:
	return flow_field[index]
	#return Vector3.ZERO

func get_field_index(cell: Vector3i) -> int:
	var offset := cell - Vector3i(bounds.position.x, 1, bounds.position.y)
	var index: int = offset.y * bounds.size.x + offset.x
	return clampi(index, 0, flow_field.size() - 1)

func get_field_direction(pos: Vector3) -> Vector3:
	var index : int = get_field_index(Vector3(pos/GRID_SIZE))
	if index < 0 or index >= flow_field.size():
		push_error("cant find flow field direction")
		return Vector3.ZERO
	return flow_field[index].normalized()

func get_neighbor_cells(current_cell: Vector3i) -> Array[Vector3i]:
	return [
		current_cell + Vector3i.FORWARD,
		current_cell + Vector3i.BACK,
		current_cell + Vector3i.LEFT,
		current_cell + Vector3i.RIGHT,
		#current_cell + Vector3i(-1,1,-1),
		#current_cell + Vector3i(1,1,-1),
		#current_cell + Vector3i(1,1,1),
		#current_cell + Vector3i(-1,1,1),
	]

func generate_flow_field() -> void:
	var next_target_tile : Vector3i = Vector3i((target.global_position / GRID_SIZE).floor())
	
	target_tile = next_target_tile
	bounds.position = Vector2i(target_tile.x - field_size.x / 2, target_tile.z - field_size.z / 2)
	costs[get_field_index(target_tile)] = 0
	
	cost_queue = [target_tile]
	var seen: Dictionary = {}
	
	while not cost_queue.is_empty():
		var current_cell = cost_queue.pop_front()
		seen[current_cell] = true
		
		var index: int = get_field_index(current_cell)
		if costs[index] == MAX_COST:
			continue
		
		for neighbor_cell in get_neighbor_cells(current_cell):
			var cell_rect: Rect2i = Rect2i(neighbor_cell.x, neighbor_cell.z, 1, 1)
			# don't revisit and skip out of bounds
			if seen.has(neighbor_cell) or not bounds.encloses(cell_rect):
				continue
			var neighbor_cell_index: int = get_field_index(neighbor_cell)
			costs[neighbor_cell_index] = costs[index] + 1
			
			cost_queue.append(neighbor_cell)
			seen[neighbor_cell] = true
			
			# Var angle
		
	for i in flow_field.size():
		var cell : Vector3i = index_to_cell(i)
		if cell == target_tile:
			continue
		
		var cheapest: int = MAX_COST
		var cheapest_neighbor := cell
		for neighbor_cell in get_neighbor_cells(cell):
			var neighbor_index: int = get_field_index(neighbor_cell)
			
			var cell_rect: Rect2i = Rect2i(neighbor_cell.x, neighbor_cell.y, 1, 1)
			# Skip out of bounds cell
			if not bounds.encloses(cell_rect):
				continue
			
			var cost:int = costs[neighbor_index]
			if cost < cheapest:
				cheapest = cost
				cheapest_neighbor = neighbor_cell
		flow_field[i] = Vector3(cheapest_neighbor - cell)
		#flow_field_gridmap.set_cell_item(cell, 0, Vector3i(DIRECTIONS.find(flow_field[i]))) # FIXME
