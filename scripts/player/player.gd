extends CharacterBody2D

@export var speed: float = 150

var character_skins = [
	"res://assets/player/men/Player_men_1.png",
	"res://assets/player/women/Player_women_1.png"
]

func _ready() -> void:
	
	var data = SaveManager.load_game(SaveManager.current_slot)
	
	var saved_id = 0
	
	if data != null and data.has("player"):
		var p_data = data["player"]
		saved_id = int(p_data.get("portrait_index", 0))
	
	if saved_id < character_skins.size():
		var skin_path = character_skins[saved_id]
		$Sprite2D.texture = load(skin_path)

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
