extends Button

@export var lose_text : String = "You lose, try again?"

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Globals.won_last_game:
		self.text = lose_text

func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Main.tscn")
