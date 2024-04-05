extends MeshInstance3D

func open_door():
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self,"rotation_degrees:y",110,1)
	
