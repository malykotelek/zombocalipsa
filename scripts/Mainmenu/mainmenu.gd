extends Control

const Menu_Save_Path: String = "res://Scens/Mainmenu/savemenu.tscn"
const Menu_Option_Path: String = "res://Scens/Mainmenu/optionmenu.tscn"

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(Menu_Save_Path)

func _on_option_button_pressed() -> void:
	get_tree().change_scene_to_file(Menu_Option_Path)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
