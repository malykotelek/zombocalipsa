extends Control

const Game_Path: String ="res://Scens/MainGame/Game.tscn"
const Game_Menu_Path: String ="res://Scens/Mainmenu/mainmenu.tscn"

@onready var slots_container = $VBoxContainer/HBoxContainer
@onready var back_button = $VBoxContainer/HBoxContainer

func _ready() -> void:
	
	back_button.pressed.connect(_on_back_button_pressed)
	
	var Test_Saves = {
		1:{"world_name": "Game", "map": "Story World","Level": "5","time": "1:57", "date": "25.03.2026"},
		2:null,
		3:null
	}
	
	var index: int = 1 
	
	for child in slots_container.get_children():
		if child is Button:
			setup_slot(child,index,Test_Saves[index])
			index += 1

func setup_slot(slot: Button, index: int, data) -> void:
	pass


func _on_save_slot_pressed() -> void:
	get_tree().change_scene_to_file(Game_Path)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Game_Menu_Path)
