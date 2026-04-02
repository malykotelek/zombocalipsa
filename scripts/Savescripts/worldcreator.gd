extends Control

@onready var world_name_input : LineEdit = $VBoxContainer/GridContainer/LineEdit
@onready var map_option : OptionButton = $VBoxContainer/GridContainer/OptionButton
@onready var difficulty_option : OptionButton = $VBoxContainer/GridContainer/OptionButton2
@onready var create_button : Button = $VBoxContainer/CreateButton
@onready var back_button : Button = $VBoxContainer/BackButton
@onready var error_label: Label = %ErrorLabel

func _ready():
	create_button.pressed.connect(_on_create_pressed)
	back_button.pressed.connect(_on_back_pressed)

func _on_create_pressed() -> void:
	var world_name := world_name_input.text.strip_edges()
	
	if world_name.is_empty():
		error_label.text = "! Enter name of the World !"
		return
	
	error_label.text = ""
	
	var map_id := map_option.selected
	var difficluty_id := difficulty_option.selected
	
	SaveManager.temp_game_data = {
		"world_name" : world_name,
		"map_id" : map_id,
		"difficluty_id" : difficluty_id
	}
	
	get_tree().change_scene_to_file("res://Scens/Mainmenu/character_creator.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scens/Mainmenu/savemenu.tscn")
