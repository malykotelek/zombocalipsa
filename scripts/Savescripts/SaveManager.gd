extends Node

const SAVE_DIR = "user://saves/"
var current_slot: int = 0

func _ready() -> void:
	if not DirAccess.dir_exists_absolute(SAVE_DIR):
		DirAccess.make_dir_absolute(SAVE_DIR)

func save_game(slot_id: int ,data: Dictionary) -> void:
	
	var file_path = SAVE_DIR + "save_slot_" + str(slot_id) + ".json"
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	
	if file:
		var json_string = JSON.stringify(data, "\t")
		file.store_string(json_string)
		file.close()

func load_game(slot_id: int):
	
	var file_path = SAVE_DIR + "save_slot_" + str(slot_id) + ".json"
	
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			var json_string = file.get_as_text()
			file.close()
			return JSON.parse_string(json_string)
	return null

func delete_game(slot_id: int) -> void:
	
	var file_path = SAVE_DIR + "save_slot_" + str(slot_id) + ".json" 
	
	if FileAccess.file_exists(file_path):
		DirAccess.remove_absolute(file_path)
