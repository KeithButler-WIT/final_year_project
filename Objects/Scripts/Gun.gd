extends Node3D

@export var bullet : PackedScene

@onready var rof_timer = $Timer
var can_shoot : bool = true

@export var muzzle_speed = 30
@export var millies_between_shots = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	$MuzzeEffect.emitting = false; # doesn't fire on start
	$MuzzeEffect.one_shot = true; # ensure only fires once per shot
	rof_timer.wait_time = millies_between_shots / 1000.0


func shoot():
	if can_shoot:
		$MuzzeEffect.emitting = true;

		var new_bullet = bullet.instantiate()
		new_bullet.global_transform = $Muzzle.global_transform
		new_bullet.speed = muzzle_speed
		get_tree().current_scene.add_child(new_bullet)
		#print("Spawning bullet")
		can_shoot = false
		rof_timer.start()


func _on_timer_timeout():
	can_shoot = true
