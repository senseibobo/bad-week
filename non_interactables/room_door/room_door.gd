extends Node3D


@export var openable: bool = false
var open = false

func _ready():
	if not openable:
		$vrata.collision_layer = 0


func _on_vrata_interacted():
	pass
