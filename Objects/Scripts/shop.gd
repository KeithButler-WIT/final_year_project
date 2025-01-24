extends Node3D

@export var dialogue_timeline : String = "shop" 
@onready var menu = $"menu"
@onready var skill_tree = $SkillTree

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu.visible = false
	skill_tree.visible = false
	Dialogic.signal_event.connect(_on_dialogic_signal)


func _process(_delta: float) -> void:
	if skill_tree.visible:
		if Input.is_key_pressed(KEY_ESCAPE):
			skill_tree.visible = false


func _on_dialogic_signal(argument:String):
	if argument == "openShopMenu":
		print("SHOWING SKILL TREE")
		skill_tree.visible = true


func _on_interactable_component_open_menu() -> void:
	menu.visible = true
	Dialogic.start(dialogue_timeline)
	# TODO open menu when option pressed


func _on_interactable_component_close_menu() -> void:
	menu.visible = false
	skill_tree.visible = false
	Dialogic.end_timeline()
