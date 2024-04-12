extends CanvasLayer


func _shovel_interacted():
	var tween = create_tween()
	tween.tween_property($ColorRect, "color:a", 0.0, 1.5)
