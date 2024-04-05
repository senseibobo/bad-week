extends Node3D

signal entered

@export var key_needed: bool = true

@onready var door = $Interactable
@onready var door_inside = $door/vRAT

func _ready():
	door.interacted.connect(on_door_interacted)
	
func on_door_interacted():
	if not key_needed or Global.player.has_key:
		door_inside.open_door()
		door.queue_free()
	else:
		Global.player.show_message("It's locked.")


func _on_area_3d_body_entered(body):
	entered.emit()
