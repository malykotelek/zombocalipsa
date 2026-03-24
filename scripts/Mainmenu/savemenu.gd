extends Control

const Game_Path: String ="res://Scens/MainGame/Game.tscn"
const Game_Menu_Path: String ="res://Scens/Mainmenu/mainmenu.tscn"

func _ready() -> void:
	
	var slots_container = $VBoxContainer/HBoxContainer
	
	$VBoxContainer/BackButton.pressed.connect(_on_back_button_pressed)
	
	var index: int = 1 
	
	for child in slots_container.get_children():
		if child is Button:
			child.pressed.connect(_on_save_slot_pressed.bind(index))
			index += 1



func _on_save_slot_pressed() -> void:
	get_tree().change_scene_to_file(Game_Path)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Game_Menu_Path)
