extends Control

const Game_Path: String ="res://Scens/MainGame/Game.tscn"
const Game_Menu_Path: String ="res://Scens/Mainmenu/mainmenu.tscn"

@onready var slots_container = $VBoxContainer/HBoxContainer
@onready var back_button = $VBoxContainer/BackButton

func _ready() -> void:
	
	back_button.pressed.connect(_on_back_button_pressed)
	
	var Test_Saves = {
		1:{"world_name": "Game", "map": "Story World","level": 67,"time": "1:57", "date": "25.03.2026"},
		2:null,
		3:null
	}
	
	var index: int = 1 
	
	for child in slots_container.get_children():
		if child is Button:
			setup_slot(child,index,Test_Saves[index])
			index += 1

func setup_slot(slot: Button, index: int, data) -> void:
	
	var vbox = slot.get_node("VBoxContainer")
	
	var delete_btn = vbox.get_node("DeleteButton")
	
	if data:
		vbox.show()
		slot.text=""
		
		vbox.get_node("WorldNameLabel").text = data["world_name"]
		vbox.get_node("MapLabel").text = "Map : %s" % data["map"]
		vbox.get_node("LevelLabel").text = "Player level : %d" % data["level"]
		vbox.get_node("TimeLabel").text = "Time in the World : %s" % data["time"]
		vbox.get_node("LastEntryLabel").text = "Last entry : %s" % data["date"]
		
		slot.pressed.connect(_on_save_slot_pressed.bind(index))
		delete_btn.pressed.connect(_on_delete_pressed.bind(index))
	else:
		vbox.hide()
		slot.text = "New Game"
		slot.pressed.connect(_on_new_game_pressed.bind(index))
		

func _on_save_slot_pressed() -> void:
	get_tree().change_scene_to_file(Game_Path)

func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file(Game_Path)

func _on_delete_pressed() -> void:
	get_tree().change_scene_to_file(Game_Path)

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Game_Menu_Path)
