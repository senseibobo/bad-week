extends Node3D
@onready var door = $Interactable
@onready var door_inside = $frizider/Vrata

var open: bool = false

func on_door_interacted():
	open = not open
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(door_inside,"rotation_degrees:y",100 if open else 0,1)
