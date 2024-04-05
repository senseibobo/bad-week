extends Interactable


var open: bool = false


func on_interact(player):
	super(player)
	open = not open
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(get_parent(), "rotation_degrees:y", 110 if open else 0, 0.5)
