extends Node3D


@export_file var dream_scene: String
@export var unable: bool = false


@onready var bed = $Interactable
@onready var room = $"../../"
@onready var main_menu = room.get_parent()

func _ready():
	bed.interacted.connect(on_bed_interacted)
	
func on_bed_interacted():
	if unable:
		Global.player.show_message("I can't sleep without my pills.")
	elif not Global.player.has_letter:
		Global.player.show_message("I haven't checked my mail yet.")
	elif not Global.player.has_pills:
		Global.player.show_message("I can't sleep without my pills.")
	else:
		Transition.transition_to(dream_scene, 4.0)
