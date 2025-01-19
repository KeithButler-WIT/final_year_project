extends Node3D

@onready var menu = $"menu"
@export var dialogue_timeline : String = "shop" 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_interactable_component_open_menu() -> void:
	menu.visible = true
	Dialogic.start(dialogue_timeline)


func _on_interactable_component_close_menu() -> void:
	menu.visible = false
	Dialogic.end_timeline()
