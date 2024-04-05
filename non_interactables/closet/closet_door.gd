extends MeshInstance3D


var open: bool = false
@export var dir = 1

func _on_interactable_interacted():
	open = not open
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rotation_degrees:y", dir*110 if open else 0, 0.4)
