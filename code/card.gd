extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func show_character(char_num):
	var character = get_node("Background/Character")
	character.set_frame(char_num - 1)
	visible = true
	

signal card_clicked(card, character)

func _on_input_event(viewport, event, shape_idx):
	if (not (event is InputEventMouseButton && event.pressed)):
		return
	if (self.name == 'ChallengeCard'):
		return
	card_clicked.emit(self, get_node("Background/Character").frame + 1)
