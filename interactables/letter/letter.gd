extends Node3D

@export var disappearing: bool = true
@export var override_time: float = 0.0
@onready var letter = $Interactable
@export_multiline var text: String = "maybe i should readthat letter by the door"

func _ready():
	letter.interacted.connect(on_letter_interacted)
	
func on_letter_interacted():
	var words = text.split(" ").size()
	Global.player.show_message(text, override_time if override_time > 0 else 2.0 + words/4.0)
	Global.player.take_letter()
	if disappearing:
		queue_free()
