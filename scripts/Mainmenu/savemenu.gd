extends Control

const Game_Path: String ="res://Scens/MainGame/Game.tscn"
const Game_Menu_Path: String ="res://Scens/Mainmenu/mainmenu.tscn"
var slot_to_delete: int = 0

@onready var slots_container = $VBoxContainer/HBoxContainer
@onready var back_button = $VBoxContainer/BackButton
@onready var delete_dialog = $DeleteDialog


func _ready() -> void:
	
	back_button.pressed.connect(_on_back_button_pressed)
	delete_dialog.confirmed.connect(_on_dialog_confirmed)
	
	var index: int = 1 
	
	for child in slots_container.get_children():
		if child is Button:
			var real_data = SaveManager.load_game(index)
			setup_slot(child, index ,real_data)
			index += 1

func setup_slot(slot: Button, index: int, data) -> void:
	
	var vbox = slot.get_node("VBoxContainer")
	
	var delete_btn = vbox.get_node("DeleteButton")

	
	if data:
		vbox.show()
		slot.text=""
		
		var map_names = ["StoryWorld","Randomly Generated"]
		var saved_map_id = int(data.get("map_id", 0))
		
		vbox.get_node("WorldNameLabel").text = str(data.get("world_name", "Unknown"))
		vbox.get_node("MapLabel").text = "Map : %s" % map_names[saved_map_id]
		vbox.get_node("LevelLabel").text = "Player level : %s" % str(data.get("level", "1"))
		vbox.get_node("TimeLabel").text = "Time in the World : %s" % str(data.get("time", "00:00"))
		vbox.get_node("LastEntryLabel").text = "Last entry : %s" % str(data.get("date", "None"))
		
		slot.pressed.connect(_on_save_slot_pressed.bind(index))
		delete_btn.pressed.connect(_on_delete_pressed.bind(index))
	else:
		vbox.hide()
		slot.text = "New Game"
		slot.pressed.connect(_on_new_game_pressed.bind(index))
		

func _on_save_slot_pressed(index: int) -> void:
	get_tree().change_scene_to_file(Game_Path)

func _on_new_game_pressed(index: int) -> void:
	SaveManager.current_slot = index
	get_tree().change_scene_to_file("res://Scens/Mainmenu/worldcreator.tscn")

func _on_delete_pressed(index: int) -> void:
	slot_to_delete = index
	delete_dialog.dialog_text = "Are you sure you want to delete the save file " + str(index) +"?"
	delete_dialog.popup_centered()

func _on_dialog_confirmed() -> void:
	SaveManager.delete_game(slot_to_delete)
	get_tree().reload_current_scene()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(Game_Menu_Path)
