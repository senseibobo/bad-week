extends Node3D

@onready var letter = $Interactable
@export_multiline var text: String = "maybe i should readthat letter by the door"

func _ready():
	letter.interacted.connect(on_letter_interacted)
	
func on_letter_interacted():
	Global.player.show_message(text, text.length()/20.0)
	Global.player.take_letter()
	queue_free()
