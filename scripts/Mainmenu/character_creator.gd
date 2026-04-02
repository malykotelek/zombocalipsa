extends Control

@onready var prev_button: Button = %leftButton
@onready var portrait_texture: TextureRect = %TextureRect
@onready var next_button: Button = %rightButton

@onready var first_name_input: LineEdit = %FirstNameInput
@onready var last_name_input: LineEdit = %LastNameInput
@onready var class_button: OptionButton = %ClassButton

@onready var error_label: Label = %ErrorLabel
@onready var create_button: Button = %CreateButton
@onready var back_button: Button = %BackButton

var portraits: Array[Texture2D] = []
var base_portraits_folder: String = "res://assets/player/"

var current_portrait_index: int = 0
var classes_data: Array = []

func _ready() -> void:
	create_button.pressed.connect(_on_create_pressed)
	back_button.pressed.connect(_on_back_pressed)
	prev_button.pressed.connect(_on_prev_pressed)
	next_button.pressed.connect(_on_next_pressed)
	
	load_portraits_from_folder()
	_update_portrait_view()
	
	load_classes_from_json()

func _update_portrait_view() -> void:
	if portraits.is_empty(): return
	
	portrait_texture.texture = portraits[current_portrait_index]

func _on_prev_pressed() -> void:
	if portraits.is_empty(): return
	current_portrait_index -= 1
	if current_portrait_index < 0:
		current_portrait_index = portraits.size() - 1
	_update_portrait_view()

func _on_next_pressed() -> void:
	if portraits.is_empty(): return
	current_portrait_index = (current_portrait_index + 1) % portraits.size()
	_update_portrait_view()

func load_portraits_from_folder() -> void:
	portraits.clear()
	
	var subfolders = ["men/", "women/"]
	
	for subfolder in subfolders:
		var current_path = base_portraits_folder + subfolder
		var dir = DirAccess.open(current_path)
		
		if dir:
			var files = dir.get_files()
			
			for file_name in files:
				if file_name.ends_with(".png"):
					var full_path = current_path + file_name
					var texture = load(full_path)
					
					if texture:
						portraits.append(texture)

func load_classes_from_json() -> void:
	var file_path = "res://data/class.json"
	class_button.clear()
	
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		classes_data = JSON.parse_string(file.get_as_text())
		file.close()
		
		var popup: PopupMenu = class_button.get_popup()
		for i in range(classes_data.size()):
			var class_info = classes_data[i]
			class_button.add_item(class_info["name"], i)
			popup.set_item_tooltip(i, class_info["description"])
	else:
		return

func _on_create_pressed() -> void:
	var f_name := first_name_input.text.strip_edges()
	var l_name := last_name_input.text.strip_edges()
	
	if f_name.is_empty() or l_name.is_empty():
		error_label.text = "! Enter first and last name !"
		return
	
	error_label.text = ""
	
	var character_data = {
		"first_name" : f_name,
		"last_name" : l_name,
		"class_id" : class_button.selected,
		"portrait_index" : current_portrait_index
	}
	
	var final_save_data = SaveManager.temp_game_data
	final_save_data["player"] = character_data
	
	SaveManager.save_game(SaveManager.current_slot, final_save_data)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scens/Mainmenu/worldcreator.tscn")
